import { useState } from 'react'
import { useQuery } from '@tanstack/react-query'
import { ArrowLeft, Download, Search, ChevronLeft, ChevronRight, RefreshCw, Filter } from 'lucide-react'
import { Link, useNavigate } from 'react-router-dom'
import api from '../../services/api'

export default function OverdueStudentsReport() {
  const [page, setPage] = useState(0)
  const [pageSize, setPageSize] = useState(30)
  const [searchTerm, setSearchTerm] = useState('')
  const [filters, setFilters] = useState({
    branchId: '',
    paymentOptionId: '',
    offer: ''
  })

  // Fetch report data
  const { data: reportData, isLoading, error, refetch } = useQuery({
    queryKey: ['overdue-students-report', filters],
    queryFn: async () => {
      const params = new URLSearchParams()
      if (filters.branchId) params.append('branchId', filters.branchId)
      if (filters.paymentOptionId) params.append('paymentOptionId', filters.paymentOptionId)
      if (filters.offer) params.append('offer', filters.offer)
      
      const response = await api.get(`/students/reports/overdue?${params.toString()}`)
      return response.data
    },
  })

  const formatCurrency = (amount) => {
    if (amount === null || amount === undefined) return 'LKR 0.00'
    return `LKR ${Number(amount).toLocaleString('en-LK', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`
  }

  const formatDate = (dateStr) => {
    if (!dateStr) return '-'
    return new Date(dateStr).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
  }

  const getDelayRowClass = (delayDays) => {
    if (delayDays > 365) return 'bg-red-50'
    if (delayDays > 180) return 'bg-orange-50'
    if (delayDays > 30) return 'bg-yellow-50'
    return ''
  }

  // Filter and paginate data
  const allData = reportData || []
  const filteredData = allData.filter(row => {
    if (!searchTerm) return true
    const search = searchTerm.toLowerCase()
    return (
      (row.nic && row.nic.toLowerCase().includes(search)) ||
      (row.studentName && row.studentName.toLowerCase().includes(search)) ||
      (row.branchName && row.branchName.toLowerCase().includes(search))
    )
  })
  
  const totalElements = filteredData.length
  const totalPages = Math.ceil(totalElements / pageSize)
  const paginatedData = filteredData.slice(page * pageSize, (page + 1) * pageSize)

  // Calculate summary
  const summary = {
    totalStudents: filteredData.length,
    totalDue: filteredData.reduce((sum, r) => sum + (r.totalDue || 0), 0),
    totalPaid: filteredData.reduce((sum, r) => sum + (r.totalPaid || 0), 0),
      }

  // Export to CSV
  const exportCSV = () => {
    const headers = [
      'NIC', 'Student Name', 'Branch', 'Payment Option', 'Scholarship %', 
      'Offer Taken', 'Offer %', 'Total Payable', 'Total Paid', 'Total Due',
      'Delay Days', 'First Payment Date', 'Last Payment Date', 'Oldest Overdue'
    ]
    
    const rows = filteredData.map(row => [
      row.nic || '',
      row.studentName || '',
      row.branchName || '',
      row.paymentOption || '',
      row.scholarshipPercentage || 0,
      row.offerTaken ? 'Yes' : 'No',
      row.offerPercentage || '-',
      row.totalPayable || 0,
      row.totalPaid || 0,
      row.totalDue || 0,
      row.totalDelayDays || 0,
      row.firstPaymentDate || '',
      row.lastPaymentDate || '',
      row.oldestOverdueDate || ''
    ])
    
    const csvContent = [headers, ...rows].map(row => row.join(',')).join('\n')
    const blob = new Blob([csvContent], { type: 'text/csv' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `overdue-students-report-${new Date().toISOString().split('T')[0]}.csv`
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
            <h1 className="text-2xl font-bold text-gray-900">Overdue Students Report</h1>
            <p className="text-gray-500">Students with overdue payments (registered from 2020)</p>
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
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-lg shadow p-4">
          <p className="text-sm text-gray-500">Total Students</p>
          <p className="text-2xl font-bold text-gray-900">{summary.totalStudents.toLocaleString()}</p>
          <p className="text-xs text-gray-400">with overdue payments</p>
        </div>
        <div className="bg-white rounded-lg shadow p-4">
          <p className="text-sm text-gray-500">Total Due</p>
          <p className="text-2xl font-bold text-red-600">{formatCurrency(summary.totalDue)}</p>
          <p className="text-xs text-gray-400">outstanding amount</p>
        </div>
        <div className="bg-white rounded-lg shadow p-4">
          <p className="text-sm text-gray-500">Total Paid</p>
          <p className="text-2xl font-bold text-green-600">{formatCurrency(summary.totalPaid)}</p>
          <p className="text-xs text-gray-400">collected so far</p>
        </div>
              </div>

      {/* Filters */}
      <div className="bg-white rounded-lg shadow p-4">
        <div className="flex flex-wrap items-center gap-4">
          <div className="flex items-center gap-2">
            <Filter className="w-4 h-4 text-gray-400" />
            <span className="text-sm font-medium text-gray-700">Filters:</span>
          </div>
          
          <select 
            className="input w-40"
            value={filters.paymentOptionId}
            onChange={(e) => { setFilters(f => ({ ...f, paymentOptionId: e.target.value })); setPage(0); }}
          >
            <option value="">All Payment Options</option>
            <option value="1">Full Payment</option>
            <option value="2">Yearly Payment</option>
            <option value="3">Semester Payment</option>
            <option value="4">Monthly Payment</option>
          </select>
          
          <select 
            className="input w-32"
            value={filters.offer}
            onChange={(e) => { setFilters(f => ({ ...f, offer: e.target.value })); setPage(0); }}
          >
            <option value="">All Offers</option>
            <option value="yes">Offer Taken</option>
            <option value="no">No Offer</option>
          </select>
          
          <div className="flex-1" />
          
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search NIC or Name..."
              className="input pl-10 w-64"
              value={searchTerm}
              onChange={(e) => { setSearchTerm(e.target.value); setPage(0); }}
            />
          </div>
          
          <select 
            className="input w-28"
            value={pageSize}
            onChange={(e) => { setPageSize(Number(e.target.value)); setPage(0); }}
          >
            <option value={30}>30 rows</option>
            <option value={50}>50 rows</option>
            <option value={100}>100 rows</option>
          </select>
        </div>
      </div>

      {/* Color Legend */}
      <div className="flex items-center gap-6 text-xs">
        <span className="text-gray-500">Delay Severity:</span>
        <span className="flex items-center gap-1"><span className="w-4 h-4 bg-red-50 border rounded"></span> &gt; 1 year</span>
        <span className="flex items-center gap-1"><span className="w-4 h-4 bg-orange-50 border rounded"></span> 6-12 months</span>
        <span className="flex items-center gap-1"><span className="w-4 h-4 bg-yellow-50 border rounded"></span> 1-6 months</span>
        <span className="flex items-center gap-1"><span className="w-4 h-4 bg-white border rounded"></span> &lt; 1 month</span>
      </div>

      {/* Table */}
      <div className="bg-white rounded-lg shadow overflow-hidden">
        {isLoading ? (
          <div className="p-8 text-center text-gray-500">Loading report data...</div>
        ) : error ? (
          <div className="p-8 text-center text-red-600">Error loading data: {error.message}</div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead>
                <tr className="bg-gray-100 text-left">
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b w-10">#</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b">NIC</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b">Student Name</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b">Branch</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b">Pay Option</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-center">Sch %</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-center">Offer</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right">Total Payable</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right">Total Paid</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right">Total Due</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-center">Delay Days</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b">First Pay</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b">Last Pay</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b">Oldest Overdue</th>
                                  </tr>
              </thead>
              <tbody>
                {paginatedData.length === 0 ? (
                  <tr>
                    <td colSpan={14} className="text-center py-8">
                      {searchTerm ? (
                        <div className="flex flex-col items-center gap-3">
                          <div className="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center">
                            <svg className="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                          </div>
                          <div className="text-lg font-semibold text-green-700">Course Fee Paid in Full!</div>
                          <div className="text-gray-600">
                            No overdue payments found for "<span className="font-medium text-gray-800">{searchTerm}</span>"
                          </div>
                          <div className="text-sm text-gray-500">
                            This student has cleared all dues or is not in the overdue list.
                          </div>
                          <Link 
                            to={`/students?nic=${encodeURIComponent(searchTerm)}`}
                            className="mt-2 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors text-sm"
                          >
                            View Student Profile
                          </Link>
                        </div>
                      ) : (
                        <span className="text-gray-500">No records found</span>
                      )}
                    </td>
                  </tr>
                ) : (
                  paginatedData.map((row, index) => (
                    <tr key={row.sId || index} className={`hover:bg-gray-100 border-b ${getDelayRowClass(row.totalDelayDays)}`}>
                      <td className="px-3 py-2 text-gray-500">{page * pageSize + index + 1}</td>
                      <td className="px-3 py-2 font-mono text-xs">
                        <Link 
                          to={`/students?nic=${encodeURIComponent(row.nic)}`}
                          className="text-blue-600 hover:text-blue-800 hover:underline"
                        >
                          {row.nic || '-'}
                        </Link>
                      </td>
                      <td className="px-3 py-2 font-medium">{row.studentName || '-'}</td>
                      <td className="px-3 py-2">{row.branchName || '-'}</td>
                      <td className="px-3 py-2">
                        <span className="px-2 py-1 bg-blue-100 text-blue-700 text-xs rounded-full">
                          {row.paymentOption || '-'}
                        </span>
                      </td>
                      <td className="px-3 py-2 text-center">{row.scholarshipPercentage || 0}%</td>
                      <td className="px-3 py-2 text-center">
                        {row.offerTaken ? (
                          <span className="px-2 py-1 bg-green-100 text-green-700 text-xs rounded-full">
                            Yes ({row.offerPercentage || 0}%)
                          </span>
                        ) : (
                          <span className="text-gray-400">-</span>
                        )}
                      </td>
                      <td className="px-3 py-2 text-right">{formatCurrency(row.totalPayable)}</td>
                      <td className="px-3 py-2 text-right text-green-600">{formatCurrency(row.totalPaid)}</td>
                      <td className="px-3 py-2 text-right font-semibold text-red-600">{formatCurrency(row.totalDue)}</td>
                      <td className="px-3 py-2 text-center">
                        <span className={`font-bold ${row.totalDelayDays > 365 ? 'text-red-600' : row.totalDelayDays > 180 ? 'text-orange-600' : 'text-gray-700'}`}>
                          {row.totalDelayDays?.toLocaleString() || 0}
                        </span>
                      </td>
                      <td className="px-3 py-2 text-xs">{formatDate(row.firstPaymentDate)}</td>
                      <td className="px-3 py-2 text-xs">{formatDate(row.lastPaymentDate)}</td>
                      <td className="px-3 py-2 text-xs text-red-600">{formatDate(row.oldestOverdueDate)}</td>
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
