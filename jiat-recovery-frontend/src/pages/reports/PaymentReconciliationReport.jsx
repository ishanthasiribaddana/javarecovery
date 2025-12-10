import { useState } from 'react'
import { useQuery } from '@tanstack/react-query'
import { ArrowLeft, Download, Search, ChevronLeft, ChevronRight, RefreshCw, AlertTriangle, CheckCircle, XCircle, FileWarning } from 'lucide-react'
import { Link } from 'react-router-dom'
import api from '../../services/api'

export default function PaymentReconciliationReport() {
  const [page, setPage] = useState(0)
  const [pageSize, setPageSize] = useState(50)
  const [searchTerm, setSearchTerm] = useState('')
  const [statusFilter, setStatusFilter] = useState('all')

  // Fetch summary data
  const { data: summary, isLoading: summaryLoading } = useQuery({
    queryKey: ['reconciliation-summary'],
    queryFn: async () => {
      const response = await api.get('/students/reports/reconciliation/summary')
      return response.data
    },
  })

  // Fetch report data
  const { data: reportData, isLoading, error, refetch } = useQuery({
    queryKey: ['reconciliation-report', statusFilter],
    queryFn: async () => {
      const params = new URLSearchParams()
      if (statusFilter && statusFilter !== 'all') params.append('status', statusFilter)
      const response = await api.get(`/students/reports/reconciliation?${params.toString()}`)
      return response.data
    },
  })

  const formatCurrency = (amount) => {
    if (amount === null || amount === undefined) return 'LKR 0.00'
    return `LKR ${Number(amount).toLocaleString('en-LK', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`
  }

  const getStatusBadge = (status) => {
    switch (status) {
      case 'MATCH':
        return <span className="px-2 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-full">Match</span>
      case 'VOUCHER_ONLY':
        return <span className="px-2 py-1 text-xs font-medium bg-blue-100 text-blue-700 rounded-full">Voucher Only</span>
      case 'SPSD_ONLY':
        return <span className="px-2 py-1 text-xs font-medium bg-purple-100 text-purple-700 rounded-full">Batches Only</span>
      case 'VOUCHER_EXCESS':
        return <span className="px-2 py-1 text-xs font-medium bg-yellow-100 text-yellow-700 rounded-full">Voucher Excess</span>
      case 'SPSD_EXCESS':
        return <span className="px-2 py-1 text-xs font-medium bg-red-100 text-red-700 rounded-full">Batches Excess</span>
      default:
        return <span className="px-2 py-1 text-xs font-medium bg-gray-100 text-gray-700 rounded-full">{status}</span>
    }
  }

  const getRowClass = (status) => {
    switch (status) {
      case 'MATCH': return 'bg-green-50'
      case 'SPSD_EXCESS': return 'bg-red-50'
      case 'VOUCHER_EXCESS': return 'bg-yellow-50'
      default: return ''
    }
  }

  // Filter and paginate data
  const allData = reportData || []
  const filteredData = allData.filter(row => {
    if (!searchTerm) return true
    const search = searchTerm.toLowerCase()
    return (
      (row.nic && row.nic.toLowerCase().includes(search)) ||
      (row.studentName && row.studentName.toLowerCase().includes(search))
    )
  })
  
  const totalElements = filteredData.length
  const totalPages = Math.ceil(totalElements / pageSize)
  const paginatedData = filteredData.slice(page * pageSize, (page + 1) * pageSize)

  // Export to CSV
  const exportCSV = () => {
    const headers = [
      'NIC', 'Student Name', 'Student Batches Total', 
      'Batch Count', 'Status'
    ]
    
    const rows = filteredData.map(row => [
      row.nic || '',
      row.studentName || '',
      row.spsdPaidTotal || 0,
      row.spsdCount || 0,
      row.status || ''
    ])

    const csvContent = [
      headers.join(','),
      ...rows.map(row => row.map(cell => `"${cell}"`).join(','))
    ].join('\n')

    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' })
    const link = document.createElement('a')
    link.href = URL.createObjectURL(blob)
    link.download = `payment_reconciliation_${new Date().toISOString().split('T')[0]}.csv`
    link.click()
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
            <h1 className="text-2xl font-bold text-gray-900">Payment Reconciliation Report</h1>
            <p className="text-gray-500">Compare voucher_item vs student_batches.total_paid_amount</p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <button onClick={() => refetch()} className="btn btn-secondary flex items-center gap-2">
            <RefreshCw className="w-4 h-4" />
            Refresh
          </button>
          <button onClick={exportCSV} className="btn btn-primary flex items-center gap-2">
            <Download className="w-4 h-4" />
            Export CSV
          </button>
        </div>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-5 gap-4">
        <div className="bg-white rounded-lg shadow p-4">
          <p className="text-sm text-gray-500">Total Students</p>
          <p className="text-2xl font-bold text-gray-900">{summary?.totalStudents?.toLocaleString() || 0}</p>
          <p className="text-xs text-gray-400">with payment records</p>
        </div>
        <div className="bg-white rounded-lg shadow p-4 border-l-4 border-green-500">
          <p className="text-sm text-gray-500">Matched</p>
          <p className="text-2xl font-bold text-green-600">{summary?.matched?.toLocaleString() || 0}</p>
          <p className="text-xs text-gray-400">data consistent</p>
        </div>
        <div className="bg-white rounded-lg shadow p-4 border-l-4 border-red-500">
          <p className="text-sm text-gray-500">Mismatched</p>
          <p className="text-2xl font-bold text-red-600">{summary?.mismatched?.toLocaleString() || 0}</p>
          <p className="text-xs text-gray-400">needs review</p>
        </div>
        <div className="bg-white rounded-lg shadow p-4 border-l-4 border-blue-500">
          <p className="text-sm text-gray-500">Voucher Only</p>
          <p className="text-2xl font-bold text-blue-600">{summary?.voucherOnly?.toLocaleString() || 0}</p>
          <p className="text-xs text-gray-400">not in student_batches</p>
        </div>
        <div className="bg-white rounded-lg shadow p-4 border-l-4 border-purple-500">
          <p className="text-sm text-gray-500">Batches Only</p>
          <p className="text-2xl font-bold text-purple-600">{summary?.spsdOnly?.toLocaleString() || 0}</p>
          <p className="text-xs text-gray-400">no voucher record</p>
        </div>
      </div>

      {/* Amount Summary */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-blue-50 rounded-lg p-4 border border-blue-200">
          <p className="text-sm text-blue-700 font-medium">Total Voucher Amount</p>
          <p className="text-xl font-bold text-blue-800">{formatCurrency(summary?.totalVoucherAmount)}</p>
        </div>
        <div className="bg-purple-50 rounded-lg p-4 border border-purple-200">
          <p className="text-sm text-purple-700 font-medium">Total Student Batches Amount</p>
          <p className="text-xl font-bold text-purple-800">{formatCurrency(summary?.totalSpsdAmount)}</p>
        </div>
        <div className={`rounded-lg p-4 border ${(summary?.totalVoucherAmount - summary?.totalSpsdAmount) > 0 ? 'bg-yellow-50 border-yellow-200' : 'bg-red-50 border-red-200'}`}>
          <p className="text-sm text-gray-700 font-medium">Discrepancy</p>
          <p className={`text-xl font-bold ${(summary?.totalVoucherAmount - summary?.totalSpsdAmount) > 0 ? 'text-yellow-700' : 'text-red-700'}`}>
            {formatCurrency(Math.abs((summary?.totalVoucherAmount || 0) - (summary?.totalSpsdAmount || 0)))}
          </p>
        </div>
      </div>

      {/* Filters */}
      <div className="bg-white rounded-lg shadow p-4">
        <div className="flex flex-wrap items-center gap-4">
          <select 
            className="input w-48"
            value={statusFilter}
            onChange={(e) => { setStatusFilter(e.target.value); setPage(0); }}
          >
            <option value="all">All Status</option>
            <option value="MATCH">Matched</option>
            <option value="mismatch">Mismatched (All)</option>
            <option value="VOUCHER_ONLY">Voucher Only</option>
            <option value="SPSD_ONLY">Batches Only</option>
            <option value="VOUCHER_EXCESS">Voucher Excess</option>
            <option value="SPSD_EXCESS">Batches Excess</option>
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
            <option value={50}>50 rows</option>
            <option value={100}>100 rows</option>
            <option value={200}>200 rows</option>
          </select>
        </div>
      </div>

      {/* Status Legend */}
      <div className="flex items-center gap-6 text-xs">
        <span className="text-gray-500">Status:</span>
        <span className="flex items-center gap-1"><CheckCircle className="w-4 h-4 text-green-500" /> Match</span>
        <span className="flex items-center gap-1"><FileWarning className="w-4 h-4 text-yellow-500" /> Voucher Excess</span>
        <span className="flex items-center gap-1"><XCircle className="w-4 h-4 text-red-500" /> Batches Excess (Data Issue)</span>
        <span className="flex items-center gap-1"><span className="w-4 h-4 bg-blue-100 rounded"></span> Voucher Only</span>
        <span className="flex items-center gap-1"><span className="w-4 h-4 bg-purple-100 rounded"></span> Batches Only</span>
      </div>

      {/* Table */}
      <div className="bg-white rounded-lg shadow overflow-hidden">
        {isLoading ? (
          <div className="p-8 text-center text-gray-500">Loading reconciliation data...</div>
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
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-right" title="Sum of student_batches.total_paid_amount">Student Batches Total</th>
                  <th className="px-3 py-3 font-semibold text-gray-700 border-b text-center" title="student_batches - Number of batch records">B.Count</th>
                </tr>
              </thead>
              <tbody>
                {paginatedData.length === 0 ? (
                  <tr>
                    <td colSpan={5} className="text-center py-8 text-gray-500">
                      No records found
                    </td>
                  </tr>
                ) : (
                  paginatedData.map((row, index) => (
                    <tr key={row.sId || index} className={`hover:bg-gray-100 border-b ${getRowClass(row.status)}`}>
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
                      <td className="px-3 py-2 text-right text-purple-600">{formatCurrency(row.spsdPaidTotal)}</td>
                      <td className="px-3 py-2 text-center">{row.spsdCount || 0}</td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        )}

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="flex items-center justify-between px-4 py-3 border-t">
            <div className="text-sm text-gray-500">
              Showing {page * pageSize + 1} to {Math.min((page + 1) * pageSize, totalElements)} of {totalElements} records
            </div>
            <div className="flex items-center gap-2">
              <button
                onClick={() => setPage(p => Math.max(0, p - 1))}
                disabled={page === 0}
                className="p-2 rounded hover:bg-gray-100 disabled:opacity-50"
              >
                <ChevronLeft className="w-5 h-5" />
              </button>
              <span className="text-sm">
                Page {page + 1} of {totalPages}
              </span>
              <button
                onClick={() => setPage(p => Math.min(totalPages - 1, p + 1))}
                disabled={page >= totalPages - 1}
                className="p-2 rounded hover:bg-gray-100 disabled:opacity-50"
              >
                <ChevronRight className="w-5 h-5" />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
