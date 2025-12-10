import { useState } from 'react'
import { useQuery } from '@tanstack/react-query'
import { 
  AlertTriangle, 
  CheckCircle, 
  ArrowLeft, 
  Download,
  Search,
  Filter,
  RefreshCw
} from 'lucide-react'
import { Link } from 'react-router-dom'
import { scholarshipDiagnosticApi } from '../../services/api'

export default function ScholarshipDiagnosticReport() {
  const [searchTerm, setSearchTerm] = useState('')
  const [statusFilter, setStatusFilter] = useState('all') // 'all', 'mismatch', 'ok', 'no_discounted_fee'

  const { data: report, isLoading, error, refetch } = useQuery({
    queryKey: ['scholarship-diagnostic'],
    queryFn: () => scholarshipDiagnosticApi.getReport().then(res => res.data),
  })

  const formatCurrency = (amount) => {
    if (amount == null) return 'N/A'
    return new Intl.NumberFormat('en-LK', {
      style: 'currency',
      currency: 'LKR',
      minimumFractionDigits: 2,
    }).format(amount)
  }

  const formatPercentage = (value) => {
    if (value == null) return 'N/A'
    return `${value}%`
  }

  // Filter data based on search and status
  const filteredData = report?.filter(item => {
    const matchesSearch = searchTerm === '' || 
      item.studentName?.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.nic?.toLowerCase().includes(searchTerm.toLowerCase()) ||
      item.studentId?.toLowerCase().includes(searchTerm.toLowerCase())
    
    const matchesStatus = statusFilter === 'all' || 
      (statusFilter === 'mismatch' && item.status === 'MISMATCH') ||
      (statusFilter === 'ok' && item.status === 'OK') ||
      (statusFilter === 'no_discounted_fee' && item.status === 'NO_DISCOUNTED_FEE')
    
    return matchesSearch && matchesStatus
  }) || []

  // Summary stats
  const totalStudents = report?.length || 0
  const mismatchCount = report?.filter(r => r.status === 'MISMATCH').length || 0
  const okCount = report?.filter(r => r.status === 'OK').length || 0
  const noDiscountedFeeCount = report?.filter(r => r.status === 'NO_DISCOUNTED_FEE').length || 0

  const exportToCSV = () => {
    if (!filteredData.length) return
    
    const headers = [
      'Student ID', 'Name', 'NIC', 'Course', 'Branch', 'Payment Option',
      'Course Fee', 'Discounted Fee (DB)', 'Scholarship %', 'Year Payment %', 'Semester Payment %',
      'Applicable %', 'Calculated Payable', 'Due Amount', 'Status'
    ]
    
    const rows = filteredData.map(item => [
      item.studentId || '',
      item.studentName || '',
      item.nic || '',
      item.courseTitle || '',
      item.branchName || '',
      item.paymentOption || '',
      item.courseFee || '',
      item.discountedFee || '',
      item.scholarshipValue || '',
      item.yearPaymentValue || '',
      item.semesterPaymentValue || '',
      item.applicableScholarshipPct || '',
      item.calculatedPayable || '',
      item.dueAmount || '',
      item.status || ''
    ])
    
    const csvContent = [headers, ...rows]
      .map(row => row.map(cell => `"${cell}"`).join(','))
      .join('\n')
    
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' })
    const link = document.createElement('a')
    link.href = URL.createObjectURL(blob)
    link.download = `scholarship_diagnostic_${new Date().toISOString().split('T')[0]}.csv`
    link.click()
  }

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-primary-600"></div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 rounded-lg p-4">
        <p className="text-red-800">Error loading report: {error.message}</p>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/reports" className="p-2 hover:bg-gray-100 rounded-lg">
            <ArrowLeft className="w-5 h-5" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Scholarship Diagnostic Report</h1>
            <p className="text-gray-500 mt-1">
              Identifies students with scholarship calculation mismatches
            </p>
          </div>
        </div>
        <div className="flex gap-2">
          <button
            onClick={() => refetch()}
            className="btn btn-secondary flex items-center gap-2"
          >
            <RefreshCw className="w-4 h-4" />
            Refresh
          </button>
          <button
            onClick={exportToCSV}
            className="btn btn-primary flex items-center gap-2"
            disabled={!filteredData.length}
          >
            <Download className="w-4 h-4" />
            Export CSV
          </button>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white rounded-lg shadow p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Total Students</p>
              <p className="text-2xl font-bold text-gray-900">{totalStudents}</p>
            </div>
            <div className="p-3 bg-blue-100 rounded-full">
              <Filter className="w-6 h-6 text-blue-600" />
            </div>
          </div>
        </div>
        
        <div className="bg-white rounded-lg shadow p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">Mismatches Found</p>
              <p className="text-2xl font-bold text-red-600">{mismatchCount}</p>
            </div>
            <div className="p-3 bg-red-100 rounded-full">
              <AlertTriangle className="w-6 h-6 text-red-600" />
            </div>
          </div>
        </div>
        
        <div className="bg-white rounded-lg shadow p-4">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500">OK Records</p>
              <p className="text-2xl font-bold text-green-600">{okCount}</p>
            </div>
            <div className="p-3 bg-green-100 rounded-full">
              <CheckCircle className="w-6 h-6 text-green-600" />
            </div>
          </div>
        </div>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-lg shadow p-4">
        <div className="flex flex-col md:flex-row gap-4">
          <div className="flex-1">
            <div className="relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
              <input
                type="text"
                placeholder="Search by name, NIC, or student ID..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-primary-500"
              />
            </div>
          </div>
          <div className="flex gap-2">
            <button
              onClick={() => setStatusFilter('all')}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                statusFilter === 'all' 
                  ? 'bg-primary-600 text-white' 
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              All ({totalStudents})
            </button>
            <button
              onClick={() => setStatusFilter('mismatch')}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                statusFilter === 'mismatch' 
                  ? 'bg-red-600 text-white' 
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              Mismatch ({mismatchCount})
            </button>
            <button
              onClick={() => setStatusFilter('ok')}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                statusFilter === 'ok' 
                  ? 'bg-green-600 text-white' 
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              OK ({okCount})
            </button>
            <button
              onClick={() => setStatusFilter('no_discounted_fee')}
              className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                statusFilter === 'no_discounted_fee' 
                  ? 'bg-yellow-600 text-white' 
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              No DB Fee ({noDiscountedFeeCount})
            </button>
          </div>
        </div>
      </div>

      {/* Data Table */}
      <div className="bg-white rounded-lg shadow overflow-hidden">
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
                <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course / Branch</th>
                <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment Option</th>
                <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Course Fee</th>
                <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Scholarship %</th>
                <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">DB Discounted</th>
                <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Calculated</th>
                <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Due Amount</th>
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {filteredData.length === 0 ? (
                <tr>
                  <td colSpan="9" className="px-4 py-8 text-center text-gray-500">
                    No records found
                  </td>
                </tr>
              ) : (
                filteredData.map((item, index) => (
                  <tr key={index} className={item.status === 'MISMATCH' ? 'bg-red-50' : item.status === 'NO_DISCOUNTED_FEE' ? 'bg-yellow-50' : ''}>
                    <td className="px-4 py-3 whitespace-nowrap">
                      {item.status === 'MISMATCH' ? (
                        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">
                          <AlertTriangle className="w-3 h-3 mr-1" />
                          MISMATCH
                        </span>
                      ) : item.status === 'NO_DISCOUNTED_FEE' ? (
                        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                          NO DB FEE
                        </span>
                      ) : (
                        <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
                          <CheckCircle className="w-3 h-3 mr-1" />
                          OK
                        </span>
                      )}
                    </td>
                    <td className="px-4 py-3">
                      <div className="text-sm font-medium text-gray-900">{item.studentName}</div>
                      <div className="text-xs text-gray-500">{item.nic}</div>
                      <div className="text-xs text-gray-400">{item.studentId}</div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="text-sm text-gray-900">{item.courseTitle || 'N/A'}</div>
                      <div className="text-xs text-gray-500">{item.branchName || 'N/A'}</div>
                    </td>
                    <td className="px-4 py-3">
                      <div className="text-sm text-gray-900">{item.paymentOption || 'N/A'}</div>
                      <div className="text-xs text-gray-500">
                        Full: {formatPercentage(item.scholarshipValue)} | 
                        Year: {formatPercentage(item.yearPaymentValue)} | 
                        Sem: {formatPercentage(item.semesterPaymentValue)}
                      </div>
                    </td>
                    <td className="px-4 py-3 text-right whitespace-nowrap">
                      <div className="text-sm font-medium text-gray-900">{formatCurrency(item.courseFee)}</div>
                    </td>
                    <td className="px-4 py-3 text-right whitespace-nowrap">
                      <div className="text-sm font-bold text-purple-600">{formatPercentage(item.applicableScholarshipPct)}</div>
                    </td>
                    <td className="px-4 py-3 text-right whitespace-nowrap">
                      <div className={`text-sm font-medium ${item.status === 'MISMATCH' ? 'text-red-600' : 'text-gray-900'}`}>
                        {formatCurrency(item.discountedFee)}
                      </div>
                    </td>
                    <td className="px-4 py-3 text-right whitespace-nowrap">
                      <div className={`text-sm font-medium ${item.status === 'MISMATCH' ? 'text-green-600' : 'text-gray-900'}`}>
                        {formatCurrency(item.calculatedPayable)}
                      </div>
                    </td>
                    <td className="px-4 py-3 text-right whitespace-nowrap">
                      <div className="text-sm font-bold text-orange-600">{formatCurrency(item.dueAmount)}</div>
                    </td>
                  </tr>
                ))
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Legend */}
      <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
        <h3 className="font-medium text-yellow-800 mb-2">Understanding This Report</h3>
        <ul className="text-sm text-yellow-700 space-y-1">
          <li><strong>MISMATCH:</strong> The stored discounted_fee in the database doesn't match the calculated payable based on the applicable scholarship percentage.</li>
          <li><strong>DB Discounted:</strong> The discounted_fee value stored in scholarship_payment_scheduler table.</li>
          <li><strong>Calculated:</strong> Course Fee × (1 - Applicable Scholarship %) - This is what the system now uses.</li>
          <li><strong>Applicable %:</strong> Based on payment option - Full uses scholarship_value, Yearly uses year_payment_value, Semester uses semester_payment_value.</li>
        </ul>
      </div>
    </div>
  )
}
