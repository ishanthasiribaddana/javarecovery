import { useParams, Link } from 'react-router-dom'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { ArrowLeft, Calculator, FileText, MessageSquare } from 'lucide-react'
import { caseApi, studentApi } from '../../services/api'
import { useAuthStore } from '../../store/authStore'
import toast from 'react-hot-toast'

export default function CaseDetail() {
  const { id } = useParams()
  const { user } = useAuthStore()
  const queryClient = useQueryClient()

  const { data: caseData, isLoading } = useQuery({
    queryKey: ['case', id],
    queryFn: () => caseApi.getById(id).then(res => res.data),
  })

  const { data: student } = useQuery({
    queryKey: ['student', caseData?.studentSId],
    queryFn: () => studentApi.getById(caseData.studentSId).then(res => res.data),
    enabled: !!caseData?.studentSId,
  })

  const { data: calculations } = useQuery({
    queryKey: ['calculations', id],
    queryFn: () => caseApi.getCalculations(id).then(res => res.data),
  })

  const calculateMutation = useMutation({
    mutationFn: (data) => caseApi.calculate(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries(['case', id])
      queryClient.invalidateQueries(['calculations', id])
      toast.success('Calculation completed!')
    },
    onError: () => toast.error('Calculation failed'),
  })

  if (isLoading) {
    return <div className="p-8 text-center text-gray-500">Loading...</div>
  }

  if (!caseData) {
    return <div className="p-8 text-center text-gray-500">Case not found</div>
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center space-x-4">
          <Link to="/cases" className="p-2 hover:bg-gray-100 rounded-lg">
            <ArrowLeft className="w-5 h-5" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold text-gray-900">{caseData.caseNumber}</h1>
            <p className="text-gray-500">Recovery Case Details</p>
          </div>
        </div>
        <StatusBadge status={caseData.status} />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Main Info */}
        <div className="lg:col-span-2 space-y-6">
          {/* Student Info */}
          <div className="card">
            <div className="card-header">
              <h2 className="text-lg font-semibold">Student Information</h2>
            </div>
            <div className="card-body">
              <dl className="grid grid-cols-2 gap-4">
                <div>
                  <dt className="text-sm text-gray-500">Student ID</dt>
                  <dd className="font-medium">{student?.studentId || caseData.studentSId}</dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Name</dt>
                  <dd className="font-medium">{student?.profileName || '-'}</dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Course</dt>
                  <dd className="font-medium">{student?.course?.courseTitle || '-'}</dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Email</dt>
                  <dd className="font-medium">{student?.generalUserProfile?.email || '-'}</dd>
                </div>
              </dl>
            </div>
          </div>

          {/* Financial Summary */}
          <div className="card">
            <div className="card-header flex items-center justify-between">
              <h2 className="text-lg font-semibold">Financial Summary</h2>
              <button
                onClick={() => calculateMutation.mutate({ 
                  calculationType: 'RECALCULATION',
                  calculatedBy: user?.id 
                })}
                disabled={calculateMutation.isPending}
                className="btn btn-primary"
              >
                <Calculator className="w-4 h-4 mr-2" />
                {calculateMutation.isPending ? 'Calculating...' : 'Recalculate'}
              </button>
            </div>
            <div className="card-body">
              <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div className="p-4 bg-gray-50 rounded-lg">
                  <p className="text-sm text-gray-500">Scholarship</p>
                  <p className="text-xl font-bold text-gray-900">
                    {caseData.originalScholarshipPercentage || 0}%
                  </p>
                </div>
                <div className="p-4 bg-gray-50 rounded-lg">
                  <p className="text-sm text-gray-500">Original Payable</p>
                  <p className="text-xl font-bold text-gray-900">
                    Rs. {(caseData.originalPayableAmount || 0).toLocaleString()}
                  </p>
                </div>
                <div className="p-4 bg-primary-50 rounded-lg">
                  <p className="text-sm text-primary-600">Current Due</p>
                  <p className="text-xl font-bold text-primary-700">
                    Rs. {(caseData.currentCalculatedDue || 0).toLocaleString()}
                  </p>
                </div>
                <div className="p-4 bg-gray-50 rounded-lg">
                  <p className="text-sm text-gray-500">Last Calculated</p>
                  <p className="text-sm font-medium text-gray-900">
                    {caseData.lastCalculationDate 
                      ? new Date(caseData.lastCalculationDate).toLocaleDateString()
                      : 'Never'}
                  </p>
                </div>
              </div>
            </div>
          </div>

          {/* Calculation History */}
          <div className="card">
            <div className="card-header">
              <h2 className="text-lg font-semibold">Calculation History</h2>
            </div>
            <div className="overflow-x-auto">
              {calculations?.length === 0 ? (
                <div className="p-8 text-center text-gray-500">
                  No calculations yet. Click "Recalculate" to generate.
                </div>
              ) : (
                <table className="table">
                  <thead>
                    <tr>
                      <th>Date</th>
                      <th>Type</th>
                      <th>Base Fee</th>
                      <th>Scholarship</th>
                      <th>Total Due</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-200">
                    {calculations?.map((calc) => (
                      <tr key={calc.id}>
                        <td>{new Date(calc.calculationDate).toLocaleDateString()}</td>
                        <td>{calc.calculationType?.replace('_', ' ')}</td>
                        <td>Rs. {(calc.baseCourseFee || 0).toLocaleString()}</td>
                        <td>{calc.scholarshipPercentage}%</td>
                        <td className="font-medium">Rs. {(calc.totalDue || 0).toLocaleString()}</td>
                        <td>
                          {calc.isApproved ? (
                            <span className="badge badge-success">Approved</span>
                          ) : (
                            <span className="badge badge-warning">Pending</span>
                          )}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Actions */}
          <div className="card">
            <div className="card-header">
              <h2 className="text-lg font-semibold">Actions</h2>
            </div>
            <div className="card-body space-y-3">
              <Link 
                to={`/reports?caseId=${id}`}
                className="btn btn-secondary w-full justify-start"
              >
                <FileText className="w-4 h-4 mr-2" />
                Generate Statement
              </Link>
              <Link 
                to={`/grievances?caseId=${id}`}
                className="btn btn-secondary w-full justify-start"
              >
                <MessageSquare className="w-4 h-4 mr-2" />
                View Grievances
              </Link>
            </div>
          </div>

          {/* Notes */}
          <div className="card">
            <div className="card-header">
              <h2 className="text-lg font-semibold">Notes</h2>
            </div>
            <div className="card-body">
              {caseData.notes ? (
                <pre className="text-sm text-gray-700 whitespace-pre-wrap font-sans">
                  {caseData.notes}
                </pre>
              ) : (
                <p className="text-sm text-gray-500">No notes added yet.</p>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

function StatusBadge({ status }) {
  const styles = {
    OPEN: 'badge-primary',
    IN_PROGRESS: 'badge-warning',
    RESOLVED: 'badge-success',
    DISPUTED: 'badge-danger',
    CLOSED: 'badge bg-gray-100 text-gray-700',
  }
  
  return (
    <span className={`badge text-base px-4 py-1 ${styles[status] || styles.OPEN}`}>
      {status?.replace('_', ' ')}
    </span>
  )
}
