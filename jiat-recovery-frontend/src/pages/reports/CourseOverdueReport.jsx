import { useState } from 'react'
import { useQuery } from '@tanstack/react-query'
import { ArrowLeft, Download, Search, ChevronLeft, ChevronRight, RefreshCw } from 'lucide-react'
import { Link } from 'react-router-dom'
import api from '../../services/api'

export default function CourseOverdueReport() {
  const [page, setPage] = useState(0)
  const [pageSize, setPageSize] = useState(50)
  const [searchTerm, setSearchTerm] = useState('')
  const [overdueFilter, setOverdueFilter] = useState('all')

  // Fetch report data for courses 321, 328, 331, 340
  const { data: reportData, isLoading, error, refetch } = useQuery({
    queryKey: ['course-overdue-report', 'all'],
    queryFn: async () => {
      const response = await api.get('/students/reports/course-overdue')
      return response.data
    },
  })

  const formatCurrency = (amount) => {
    if (amount === null || amount === undefined) return 'LKR 0.00'
    return `LKR ${Number(amount).toLocaleString('en-LK', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`
  }

  const formatDate = (dateStr) => {
    if (!dateStr) return 'No Payment'
    return new Date(dateStr).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
  }

  const getOverdueRowClass = (daysOverdue, hasPayment) => {
    if (!hasPayment) return 'bg-red-100'
    if (daysOverdue > 365) return 'bg-red-50'
    if (daysOverdue > 180) return 'bg-orange-50'
    if (daysOverdue > 90) return 'bg-yellow-50'
    return ''
  }

  // Filter and paginate data
  const allData = reportData || []
  const filteredData = allData.filter(row => {
    // Text search filter
    if (searchTerm) {
      const search = searchTerm.toLowerCase()
      const matchesSearch = (
        (row.nic && row.nic.toLowerCase().includes(search)) ||
        (row.studentName && row.studentName.toLowerCase().includes(search)) ||
        (row.contactNumber && row.contactNumber.toLowerCase().includes(search))
      )
      if (!matchesSearch) return false
    }
    
    // Overdue category filter
    if (overdueFilter !== 'all') {
      const days = row.daysOverdue || 0
      switch (overdueFilter) {
        case '0-30':
          if (days > 30) return false
          break
        case '30-60':
          if (days <= 30 || days > 60) return false
          break
        case '60-90':
          if (days <= 60 || days > 90) return false
          break
        case '90+':
          if (days <= 90) return false
          break
        default:
          break
      }
    }
    
    return true
  })
  
  const totalElements = filteredData.length
  const totalPages = Math.ceil(totalElements / pageSize)
  const paginatedData = filteredData.slice(page * pageSize, (page + 1) * pageSize)

  // Calculate summary based on filtered data
  const getCriticalCount = () => {
    switch (overdueFilter) {
      case '0-30':
        return filteredData.filter(r => r.daysOverdue <= 30).length
      case '30-60':
        return filteredData.filter(r => r.daysOverdue > 30 && r.daysOverdue <= 60).length
      case '60-90':
        return filteredData.filter(r => r.daysOverdue > 60 && r.daysOverdue <= 90).length
      case '90+':
        return filteredData.filter(r => r.daysOverdue > 90).length
      default:
        return filteredData.filter(r => r.daysOverdue > 90).length
    }
  }
  
  const getCriticalLabel = () => {
    switch (overdueFilter) {
      case '0-30': return '0-30 Days'
      case '30-60': return '30-60 Days'
      case '60-90': return '60-90 Days'
      case '90+': return '>90 Days'
      default: return '>90 Days Overdue'
    }
  }
  
  const summary = {
    totalStudents: filteredData.length,
    totalDue: filteredData.reduce((sum, r) => sum + (r.dueAmount || 0), 0),
    totalPaid: filteredData.reduce((sum, r) => sum + (r.totalPaid || 0), 0),
    noPayments: filteredData.filter(r => !r.lastPaymentDate).length,
    criticalCount: getCriticalCount(),
    criticalLabel: getCriticalLabel(),
  }

  // Export to CSV
  const exportCSV = () => {
    const headers = [
      '#', 'NIC', 'Student Name', 'Course Fee', 'Scholarship %',
      'Payable Fee', 'Total Paid', 'Due Amount', 'Calculated Balance', 'Last Payment Date', 'Days Overdue'
    ]
    
    const rows = filteredData.map((row, idx) => [
      idx + 1,
      row.nic || '',
      row.studentName || '',
      row.courseFee || 0,
      row.scholarshipPct || 0,
      row.payableFee || 0,
      row.totalPaid || 0,
      row.dueAmount || 0,
      row.calculatedBalance || 0,
      row.lastPaymentDate || 'No Payment',
      row.daysOverdue || 0
    ])
    
    const csvContent = [headers, ...rows].map(row => row.join(',')).join('\n')
    const blob = new Blob([csvContent], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `your-campus-overdue-report-${new Date().toISOString().split('T')[0]}.csv`
    a.click()
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
            <h1 className="text-2xl font-bold text-gray-900">Your Campus - Overdue Report</h1>
            <p className="text-gray-500">All Courses (321, 328, 331, 340) - Students with Outstanding Balance</p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <button 
            onClick={() => refetch()} 
            className="btn btn-secondary flex items-center gap-2"
          >
            <RefreshCw className="w-4 h-4" />
            Refresh
          </button>
          <button 
            onClick={exportCSV}
            className="btn btn-primary flex items-center gap-2"
          >
            <Download className="w-4 h-4" />
            Export CSV
          </button>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-5 gap-2">
        <div className="bg-white rounded-lg shadow px-3 py-2">
          <p className="text-xs text-gray-500">Total Students</p>
          <p className="text-lg font-bold text-gray-900">{summary.totalStudents.toLocaleString()}</p>
        </div>
        <div className="bg-white rounded-lg shadow px-3 py-2">
          <p className="text-xs text-gray-500">Total Due</p>
          <p className="text-lg font-bold text-red-600">{formatCurrency(summary.totalDue)}</p>
        </div>
        <div className="bg-white rounded-lg shadow px-3 py-2">
          <p className="text-xs text-gray-500">Total Paid</p>
          <p className="text-lg font-bold text-green-600">{formatCurrency(summary.totalPaid)}</p>
        </div>
        <div className="bg-white rounded-lg shadow px-3 py-2">
          <p className="text-xs text-gray-500">No Payments</p>
          <p className="text-lg font-bold text-red-700">{summary.noPayments.toLocaleString()}</p>
        </div>
        <div className="bg-white rounded-lg shadow px-3 py-2">
          <p className="text-xs text-gray-500">{summary.criticalLabel}</p>
          <p className="text-lg font-bold text-orange-600">{summary.criticalCount.toLocaleString()}</p>
        </div>
      </div>

      {/* Search and Filters */}
      <div className="bg-white rounded-lg shadow p-4">
        <div className="flex flex-wrap items-center gap-4">
          <div className="relative flex-1 min-w-[200px]">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search by NIC, Name, or Contact..."
              className="input pl-10 w-full"
              value={searchTerm}
              onChange={(e) => { setSearchTerm(e.target.value); setPage(0); }}
            />
          </div>
          
          <select 
            className="input w-44"
            value={overdueFilter}
            onChange={(e) => { setOverdueFilter(e.target.value); setPage(0); }}
          >
            <option value="all">All Overdue</option>
            <option value="0-30">0-30 Days</option>
            <option value="30-60">30-60 Days</option>
            <option value="60-90">60-90 Days</option>
            <option value="90+">Over 90 Days</option>
          </select>
          
          <select 
            className="input w-28"
            value={pageSize}
            onChange={(e) => { setPageSize(Number(e.target.value)); setPage(0); }}
          >
            <option value={30}>30 rows</option>
            <option value={50}>50 rows</option>
            <option value={100}>100 rows</option>
            <option value={500}>500 rows</option>
          </select>
        </div>
      </div>


      {/* Table */}
      <div className="bg-white rounded-lg shadow overflow-hidden">
        {isLoading ? (
          <div className="p-8 text-center text-gray-500">Loading report data...</div>
        ) : error ? (
          <div className="p-8 text-center text-red-600">Error loading data: {error.message}</div>
        ) : (
          <div className="overflow-x-auto max-h-[calc(100vh-350px)]">
            <table className="w-full text-sm">
              <thead className="sticky top-0 z-10">
                <tr className="bg-gray-100 text-left">
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b w-12 bg-gray-100">#</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b bg-gray-100">NIC</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b bg-gray-100">Student Name</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right bg-gray-100">Course Fee</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-center bg-gray-100">Sch %</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right bg-gray-100">Course Fee Payable</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right bg-gray-100">Paid</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right bg-gray-100">Due</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right bg-gray-100">Balance</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b bg-gray-100">Last Payment</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-center bg-gray-100">Days Overdue</th>
                </tr>
              </thead>
              <tbody>
                {paginatedData.length === 0 ? (
                  <tr>
                    <td colSpan={11} className="text-center py-8 text-gray-500">
                      No records found
                    </td>
                  </tr>
                ) : (
                  paginatedData.map((row, index) => (
                    <tr 
                      key={row.nic || index} 
                      className={`hover:bg-gray-100 border-b ${getOverdueRowClass(row.daysOverdue, row.lastPaymentDate)}`}
                    >
                      <td className="px-3 py-2 text-gray-500">{page * pageSize + index + 1}</td>
                      <td className="px-3 py-2 font-mono text-xs">
                        <a 
                          href={`/students?nic=${encodeURIComponent(row.nic)}`}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-blue-600 hover:text-blue-800 hover:underline"
                        >
                          {row.nic || '-'}
                        </a>
                      </td>
                      <td className="px-3 py-2 font-medium">{row.studentName || '-'}</td>
                      <td className="px-3 py-2 text-right">{formatCurrency(row.courseFee)}</td>
                      <td className="px-3 py-2 text-center">
                        <span className="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">
                          {row.scholarshipPct || 0}%
                        </span>
                      </td>
                      <td className="px-3 py-2 text-right">{formatCurrency(row.payableFee)}</td>
                      <td className="px-3 py-2 text-right text-green-600">{formatCurrency(row.totalPaid)}</td>
                      <td className="px-3 py-2 text-right font-semibold text-red-600">{formatCurrency(row.dueAmount)}</td>
                      <td className="px-3 py-2 text-right font-semibold text-purple-600">{formatCurrency(row.calculatedBalance)}</td>
                      <td className="px-3 py-2 text-xs">
                        {row.lastPaymentDate ? (
                          formatDate(row.lastPaymentDate)
                        ) : (
                          <span className="text-red-600 font-semibold">No Payment</span>
                        )}
                      </td>
                      <td className="px-3 py-2 text-center">
                        <span className={`font-bold ${
                          !row.lastPaymentDate ? 'text-red-700' :
                          row.daysOverdue > 365 ? 'text-red-600' : 
                          row.daysOverdue > 180 ? 'text-orange-600' : 
                          row.daysOverdue > 90 ? 'text-yellow-600' :
                          'text-gray-700'
                        }`}>
                          {row.daysOverdue?.toLocaleString() || 0}
                        </span>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        )}

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="px-4 py-3 border-t flex items-center justify-between bg-gray-50">
            <p className="text-sm text-gray-500">
              Showing {page * pageSize + 1} to {Math.min((page + 1) * pageSize, totalElements)} of {totalElements.toLocaleString()} students
            </p>
            <div className="flex items-center gap-2">
              <button
                className="p-2 rounded border bg-white hover:bg-gray-100 disabled:opacity-50"
                onClick={() => setPage(p => Math.max(0, p - 1))}
                disabled={page === 0}
              >
                <ChevronLeft className="w-4 h-4" />
              </button>
              <span className="px-4 py-2 text-sm">
                Page {page + 1} of {totalPages}
              </span>
              <button
                className="p-2 rounded border bg-white hover:bg-gray-100 disabled:opacity-50"
                onClick={() => setPage(p => Math.min(totalPages - 1, p + 1))}
                disabled={page >= totalPages - 1}
              >
                <ChevronRight className="w-4 h-4" />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
