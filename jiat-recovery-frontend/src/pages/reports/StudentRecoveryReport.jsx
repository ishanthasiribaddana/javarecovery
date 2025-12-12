import { useState } from 'react'
import { useQuery } from '@tanstack/react-query'
import { 
  Users, 
  Download, 
  Search,
  Phone,
  Percent,
  DollarSign,
  AlertCircle,
  CheckCircle,
  Loader2
} from 'lucide-react'
import { recoveryReportApi } from '../../services/api'
import { useNavigate } from 'react-router-dom'

export default function StudentRecoveryReport() {
  const [searchTerm, setSearchTerm] = useState('')
  const navigate = useNavigate()

  const { data: report, isLoading, error } = useQuery({
    queryKey: ['student-recovery-report'],
    queryFn: () => recoveryReportApi.getReport(100).then(res => res.data),
  })

  const filteredData = report?.filter(student => 
    student.nic?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    student.studentName?.toLowerCase().includes(searchTerm.toLowerCase()) ||
    student.studentId?.toLowerCase().includes(searchTerm.toLowerCase())
  ) || []

  const formatCurrency = (amount) => {
    return new Intl.NumberFormat('en-LK', {
      style: 'currency',
      currency: 'LKR',
      minimumFractionDigits: 2
    }).format(amount || 0)
  }

  const getStatusBadge = (dueAmount, paidAmount, payableFee) => {
    if (dueAmount <= 0 || paidAmount >= payableFee) {
      return <span className="px-2 py-1 text-xs font-medium rounded-full bg-green-100 text-green-800">Paid</span>
    } else if (dueAmount > payableFee * 0.5) {
      return <span className="px-2 py-1 text-xs font-medium rounded-full bg-red-100 text-red-800">High Due</span>
    } else {
      return <span className="px-2 py-1 text-xs font-medium rounded-full bg-yellow-100 text-yellow-800">Partial</span>
    }
  }

  const handleRowClick = (nic) => {
    navigate(`/students/search?nic=${encodeURIComponent(nic)}`)
  }

  const exportToCSV = () => {
    if (!filteredData.length) return
    
    const headers = ['NIC', 'Student ID', 'Name', 'Phone', 'Scholarship %', 'Payable Fee', 'Paid Amount', 'Due Amount', 'First Payment Date']
    const csvContent = [
      headers.join(','),
      ...filteredData.map(row => [
        row.nic,
        row.studentId,
        `"${row.studentName}"`,
        row.phone || '',
        row.scholarshipPercentage,
        row.payableFee,
        row.paidAmount,
        row.dueAmount,
        row.firstPaymentDate
      ].join(','))
    ].join('\n')

    const blob = new Blob([csvContent], { type: 'text/csv' })
    const url = window.URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `student-recovery-report-${new Date().toISOString().split('T')[0]}.csv`
    a.click()
    window.URL.revokeObjectURL(url)
  }

  // Summary calculations
  const totalPayable = filteredData.reduce((sum, s) => sum + (s.payableFee || 0), 0)
  const totalPaid = filteredData.reduce((sum, s) => sum + (s.paidAmount || 0), 0)
  const totalDue = filteredData.reduce((sum, s) => sum + (s.dueAmount || 0), 0)
  const avgScholarship = filteredData.length > 0 
    ? filteredData.reduce((sum, s) => sum + (s.scholarshipPercentage || 0), 0) / filteredData.length 
    : 0

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Student Recovery Report</h1>
          <p className="text-gray-500 mt-1">100 students registered after December 31, 2020</p>
        </div>
        <button
          onClick={exportToCSV}
          disabled={!filteredData.length}
          className="btn btn-primary flex items-center gap-2"
        >
          <Download className="w-4 h-4" />
          Export CSV
        </button>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-lg shadow p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-blue-100 rounded-lg">
              <Users className="w-5 h-5 text-blue-600" />
            </div>
            <div>
              <p className="text-sm text-gray-500">Total Students</p>
              <p className="text-xl font-bold text-gray-900">{filteredData.length}</p>
            </div>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-green-100 rounded-lg">
              <CheckCircle className="w-5 h-5 text-green-600" />
            </div>
            <div>
              <p className="text-sm text-gray-500">Total Paid</p>
              <p className="text-xl font-bold text-green-600">{formatCurrency(totalPaid)}</p>
            </div>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-red-100 rounded-lg">
              <AlertCircle className="w-5 h-5 text-red-600" />
            </div>
            <div>
              <p className="text-sm text-gray-500">Total Due</p>
              <p className="text-xl font-bold text-red-600">{formatCurrency(totalDue)}</p>
            </div>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow p-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-purple-100 rounded-lg">
              <Percent className="w-5 h-5 text-purple-600" />
            </div>
            <div>
              <p className="text-sm text-gray-500">Avg Scholarship</p>
              <p className="text-xl font-bold text-purple-600">{avgScholarship.toFixed(1)}%</p>
            </div>
          </div>
        </div>
      </div>

      {/* Test NICs Info */}
      <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
        <h3 className="font-semibold text-blue-800 mb-2">10 Test NICs with Different Scenarios:</h3>
        <div className="grid grid-cols-2 md:grid-cols-5 gap-2 text-sm">
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">199977802542</span>
            <p className="text-xs text-gray-500">High Due</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200229003379</span>
            <p className="text-xs text-gray-500">High Due</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200132502268</span>
            <p className="text-xs text-gray-500">74% Scholarship</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200136100148</span>
            <p className="text-xs text-gray-500">74% Scholarship</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200116102836</span>
            <p className="text-xs text-gray-500">75% Scholarship</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200652603500</span>
            <p className="text-xs text-gray-500">74% Scholarship</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200204403699</span>
            <p className="text-xs text-gray-500">74% Scholarship</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200320810314</span>
            <p className="text-xs text-gray-500">72% Scholarship</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200528103722</span>
            <p className="text-xs text-gray-500">75% Scholarship</p>
          </div>
          <div className="bg-white rounded p-2">
            <span className="font-mono text-blue-600">200167301078</span>
            <p className="text-xs text-gray-500">74% Scholarship</p>
          </div>
        </div>
      </div>

      {/* Search */}
      <div className="bg-white rounded-lg shadow p-4">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
          <input
            type="text"
            placeholder="Search by NIC, Student ID, or Name..."
            className="input pl-10 w-full"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>
      </div>

      {/* Data Table */}
      <div className="bg-white rounded-lg shadow overflow-hidden">
        {isLoading ? (
          <div className="flex items-center justify-center py-12">
            <Loader2 className="w-8 h-8 animate-spin text-primary-600" />
            <span className="ml-2 text-gray-500">Loading report...</span>
          </div>
        ) : error ? (
          <div className="text-center py-12 text-red-500">
            <AlertCircle className="w-12 h-12 mx-auto mb-2" />
            <p>Failed to load report. Please try again.</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">NIC</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                  <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Phone</th>
                  <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Scholarship %</th>
                  <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Payable Fee</th>
                  <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Paid Amount</th>
                  <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Due Amount</th>
                  <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {filteredData.map((student, index) => (
                  <tr 
                    key={index} 
                    className="hover:bg-gray-50 cursor-pointer"
                    onClick={() => handleRowClick(student.nic)}
                  >
                    <td className="px-4 py-3 whitespace-nowrap">
                      <span className="font-mono text-sm text-blue-600">{student.nic}</span>
                    </td>
                    <td className="px-4 py-3 whitespace-nowrap">
                      <span className="font-medium text-gray-900">{student.studentName}</span>
                    </td>
                    <td className="px-4 py-3 whitespace-nowrap text-sm text-gray-500">
                      {student.phone ? (
                        <span className="flex items-center gap-1">
                          <Phone className="w-3 h-3" />
                          {student.phone}
                        </span>
                      ) : '-'}
                    </td>
                    <td className="px-4 py-3 whitespace-nowrap text-center">
                      <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-purple-100 text-purple-800">
                        {student.scholarshipPercentage || 0}%
                      </span>
                    </td>
                    <td className="px-4 py-3 whitespace-nowrap text-right text-sm text-gray-900">
                      {formatCurrency(student.payableFee)}
                    </td>
                    <td className="px-4 py-3 whitespace-nowrap text-right text-sm text-green-600 font-medium">
                      {formatCurrency(student.paidAmount)}
                    </td>
                    <td className="px-4 py-3 whitespace-nowrap text-right text-sm text-red-600 font-bold">
                      {formatCurrency(student.dueAmount)}
                    </td>
                    <td className="px-4 py-3 whitespace-nowrap text-center">
                      {getStatusBadge(student.dueAmount, student.paidAmount, student.payableFee)}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
            {filteredData.length === 0 && !isLoading && (
              <div className="text-center py-12 text-gray-500">
                <Users className="w-12 h-12 mx-auto mb-2 text-gray-300" />
                <p>No students found matching your search.</p>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  )
}
