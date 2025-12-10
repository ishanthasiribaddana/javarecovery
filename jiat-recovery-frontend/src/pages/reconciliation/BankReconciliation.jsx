import { useState } from 'react'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { Upload, Check, X, Search } from 'lucide-react'
import { reconciliationApi, studentApi } from '../../services/api'
import toast from 'react-hot-toast'

export default function BankReconciliation() {
  const [file, setFile] = useState(null)
  const [matchingDeposit, setMatchingDeposit] = useState(null)
  const [studentSearch, setStudentSearch] = useState('')
  const queryClient = useQueryClient()

  const { data: unmatchedDeposits, isLoading } = useQuery({
    queryKey: ['unmatchedDeposits'],
    queryFn: () => reconciliationApi.getUnmatched().then(res => res.data),
  })

  const { data: searchResults } = useQuery({
    queryKey: ['studentSearch', studentSearch],
    queryFn: () => studentApi.search(studentSearch, 10).then(res => res.data),
    enabled: studentSearch.length >= 2,
  })

  const importMutation = useMutation({
    mutationFn: (formData) => reconciliationApi.importFile(formData),
    onSuccess: () => {
      queryClient.invalidateQueries(['unmatchedDeposits'])
      toast.success('File imported successfully!')
      setFile(null)
    },
    onError: () => toast.error('Import failed'),
  })

  const matchMutation = useMutation({
    mutationFn: ({ depositId, studentSId }) => 
      reconciliationApi.matchDeposit(depositId, { studentSId }),
    onSuccess: () => {
      queryClient.invalidateQueries(['unmatchedDeposits'])
      toast.success('Deposit matched!')
      setMatchingDeposit(null)
      setStudentSearch('')
    },
    onError: () => toast.error('Match failed'),
  })

  const handleFileUpload = (e) => {
    const selectedFile = e.target.files[0]
    if (selectedFile) {
      setFile(selectedFile)
    }
  }

  const handleImport = () => {
    if (!file) return
    const formData = new FormData()
    formData.append('file', file)
    importMutation.mutate(formData)
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Bank Reconciliation</h1>
        <p className="text-gray-500 mt-1">Import and match bank deposits to students</p>
      </div>

      {/* Import Section */}
      <div className="card">
        <div className="card-header">
          <h2 className="text-lg font-semibold">Import Bank Statement</h2>
        </div>
        <div className="card-body">
          <div className="flex items-center gap-4">
            <label className="flex-1">
              <div className="flex items-center justify-center w-full h-32 border-2 border-dashed border-gray-300 rounded-lg cursor-pointer hover:border-primary-400 hover:bg-primary-50 transition-colors">
                <div className="text-center">
                  <Upload className="w-8 h-8 text-gray-400 mx-auto mb-2" />
                  <p className="text-sm text-gray-600">
                    {file ? file.name : 'Click to upload CSV or Excel file'}
                  </p>
                </div>
              </div>
              <input
                type="file"
                className="hidden"
                accept=".csv,.xlsx,.xls"
                onChange={handleFileUpload}
              />
            </label>
            <button
              onClick={handleImport}
              disabled={!file || importMutation.isPending}
              className="btn btn-primary"
            >
              {importMutation.isPending ? 'Importing...' : 'Import'}
            </button>
          </div>
        </div>
      </div>

      {/* Unmatched Deposits */}
      <div className="card">
        <div className="card-header">
          <h2 className="text-lg font-semibold">Unmatched Deposits</h2>
        </div>
        <div className="overflow-x-auto">
          {isLoading ? (
            <div className="p-8 text-center text-gray-500">Loading...</div>
          ) : unmatchedDeposits?.length === 0 ? (
            <div className="p-8 text-center text-gray-500">
              No unmatched deposits. Import a bank statement to get started.
            </div>
          ) : (
            <table className="table">
              <thead>
                <tr>
                  <th>Date</th>
                  <th>Reference</th>
                  <th>Description</th>
                  <th>Amount</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {unmatchedDeposits?.map((deposit) => (
                  <tr key={deposit.id}>
                    <td>{new Date(deposit.transactionDate).toLocaleDateString()}</td>
                    <td className="font-mono text-sm">{deposit.referenceNumber}</td>
                    <td className="max-w-xs truncate">{deposit.description}</td>
                    <td className="font-medium">
                      Rs. {(deposit.amount || 0).toLocaleString()}
                    </td>
                    <td>
                      <button
                        onClick={() => setMatchingDeposit(deposit)}
                        className="btn btn-primary btn-sm"
                      >
                        Match
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>

      {/* Match Modal */}
      {matchingDeposit && (
        <div className="fixed inset-0 bg-gray-900/50 flex items-center justify-center z-50">
          <div className="bg-white rounded-xl shadow-xl max-w-lg w-full mx-4">
            <div className="p-6 border-b border-gray-200">
              <h3 className="text-lg font-semibold">Match Deposit to Student</h3>
              <p className="text-sm text-gray-500 mt-1">
                Reference: {matchingDeposit.referenceNumber} | 
                Amount: Rs. {matchingDeposit.amount?.toLocaleString()}
              </p>
            </div>
            <div className="p-6">
              <div className="relative mb-4">
                <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
                <input
                  type="text"
                  placeholder="Search student by name or ID..."
                  className="input pl-10"
                  value={studentSearch}
                  onChange={(e) => setStudentSearch(e.target.value)}
                />
              </div>
              
              {searchResults?.length > 0 && (
                <div className="max-h-60 overflow-y-auto border border-gray-200 rounded-lg">
                  {searchResults.map((student) => (
                    <button
                      key={student.sId}
                      onClick={() => matchMutation.mutate({
                        depositId: matchingDeposit.id,
                        studentSId: student.sId
                      })}
                      className="w-full p-3 text-left hover:bg-gray-50 border-b border-gray-100 last:border-0"
                    >
                      <p className="font-medium">{student.profileName}</p>
                      <p className="text-sm text-gray-500">{student.studentId}</p>
                    </button>
                  ))}
                </div>
              )}
            </div>
            <div className="p-6 border-t border-gray-200 flex justify-end gap-3">
              <button
                onClick={() => {
                  setMatchingDeposit(null)
                  setStudentSearch('')
                }}
                className="btn btn-secondary"
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
