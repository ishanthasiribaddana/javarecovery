import { useState } from 'react'
import { useQuery } from '@tanstack/react-query'
import { ArrowLeft, Download, Search, ChevronLeft, ChevronRight } from 'lucide-react'
import { Link } from 'react-router-dom'
import { outstandingApi } from '../../services/api'

export default function OutstandingReport() {
  const [page, setPage] = useState(0)
  const [pageSize, setPageSize] = useState(50)
  const [searchTerm, setSearchTerm] = useState('')
  const [debouncedSearch, setDebouncedSearch] = useState('')

  // Debounce search
  const handleSearch = (value) => {
    setSearchTerm(value)
    setTimeout(() => {
      setDebouncedSearch(value)
      setPage(0)
    }, 500)
  }

  const { data, isLoading, error } = useQuery({
    queryKey: ['outstanding-report', page, pageSize, debouncedSearch],
    queryFn: () => outstandingApi.getReport(page, pageSize, debouncedSearch),
  })

  const formatCurrency = (amount) => {
    if (amount === null || amount === undefined) return 'Rs. 0'
    return `Rs. ${amount.toLocaleString('en-LK', { minimumFractionDigits: 2 })}`
  }

  const formatNumber = (amount) => {
    if (amount === null || amount === undefined) return '0'
    return amount.toLocaleString('en-US', { minimumFractionDigits: 0, maximumFractionDigits: 0 })
  }

  const totalPages = data?.data?.totalPages || 0
  const totalElements = data?.data?.totalElements || 0
  const content = data?.data?.content || []
  const summary = data?.data?.summary || {}

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/dashboard" className="p-2 hover:bg-gray-100 rounded-lg">
            <ArrowLeft className="w-5 h-5" />
          </Link>
          <div>
            <h1 className="text-2xl font-bold text-gray-900">Outstanding Report</h1>
            <p className="text-gray-500">Active students with outstanding balances</p>
          </div>
        </div>
        <button className="btn btn-primary flex items-center gap-2">
          <Download className="w-4 h-4" />
          Export CSV
        </button>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="card">
          <div className="card-body">
            <p className="text-sm text-gray-500">Total Students</p>
            <p className="text-2xl font-bold">{totalElements.toLocaleString()}</p>
          </div>
        </div>
        <div className="card">
          <div className="card-body">
            <p className="text-sm text-gray-500">Total Outstanding</p>
            <p className="text-2xl font-bold text-danger-600">{formatCurrency(summary.totalOutstanding)}</p>
          </div>
        </div>
        <div className="card">
          <div className="card-body">
            <p className="text-sm text-gray-500">Total Paid</p>
            <p className="text-2xl font-bold text-success-600">{formatCurrency(summary.totalPaid)}</p>
          </div>
        </div>
        <div className="card">
          <div className="card-body">
            <p className="text-sm text-gray-500">Total Course Fees</p>
            <p className="text-2xl font-bold">{formatCurrency(summary.totalCourseFee)}</p>
          </div>
        </div>
      </div>

      {/* Search */}
      <div className="card">
        <div className="card-body">
          <div className="flex items-center gap-4">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
              <input
                type="text"
                placeholder="Search by NIC or Name..."
                className="input pl-10 w-full"
                value={searchTerm}
                onChange={(e) => handleSearch(e.target.value)}
              />
            </div>
            <select 
              className="input w-32"
              value={pageSize}
              onChange={(e) => { setPageSize(Number(e.target.value)); setPage(0); }}
            >
              <option value={25}>25 rows</option>
              <option value={50}>50 rows</option>
              <option value={100}>100 rows</option>
            </select>
          </div>
        </div>
      </div>

      {/* Table */}
      <div className="card">
        <div className="card-body p-0">
          {isLoading ? (
            <div className="p-8 text-center text-gray-500">Loading...</div>
          ) : error ? (
            <div className="p-8 text-center text-danger-600">Error loading data</div>
          ) : (
            <div className="overflow-x-auto">
              <table className="table">
                <thead>
                  <tr className="bg-gray-100">
                    <th className="w-12 text-center border">#</th>
                    <th className="border">NIC</th>
                    <th className="border">Name</th>
                    <th className="text-center border">Scholarship Perc</th>
                    <th className="text-right border">Payable Amount</th>
                    <th className="text-right border">Total Paid</th>
                    <th className="text-right border">Due</th>
                  </tr>
                </thead>
                <tbody>
                  {content.length === 0 ? (
                    <tr>
                      <td colSpan={7} className="text-center py-8 text-gray-500 border">
                        No records found
                      </td>
                    </tr>
                  ) : (
                    content.map((row, index) => (
                      <tr key={row.id} className="hover:bg-gray-50">
                        <td className="text-center border">{page * pageSize + index + 1}</td>
                        <td className="font-mono border">{row.nic || '-'}</td>
                        <td className="border">{row.studentName || '-'}</td>
                        <td className="text-center border">{row.scholarshipPercentage || 0}%</td>
                        <td className="text-right border">{formatNumber(row.payableAmount)}</td>
                        <td className="text-right border">{formatNumber(row.paidAmount)}</td>
                        <td className="text-right border">{formatNumber(row.balanceDue)}</td>
                      </tr>
                    ))
                  )}
                </tbody>
              </table>
            </div>
          )}
        </div>

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="card-body border-t flex items-center justify-between">
            <p className="text-sm text-gray-500">
              Showing {page * pageSize + 1} to {Math.min((page + 1) * pageSize, totalElements)} of {totalElements.toLocaleString()} entries
            </p>
            <div className="flex items-center gap-2">
              <button
                className="btn btn-secondary p-2"
                onClick={() => setPage(p => Math.max(0, p - 1))}
                disabled={page === 0}
              >
                <ChevronLeft className="w-4 h-4" />
              </button>
              <span className="px-4 py-2 text-sm">
                Page {page + 1} of {totalPages}
              </span>
              <button
                className="btn btn-secondary p-2"
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
