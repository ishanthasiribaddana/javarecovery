import { useState } from 'react'
import { useQuery } from '@tanstack/react-query'
import { Link, useSearchParams } from 'react-router-dom'
import { Plus, Search, Filter } from 'lucide-react'
import { caseApi } from '../../services/api'

const statusOptions = [
  { value: '', label: 'All Status' },
  { value: 'OPEN', label: 'Open' },
  { value: 'IN_PROGRESS', label: 'In Progress' },
  { value: 'DISPUTED', label: 'Disputed' },
  { value: 'RESOLVED', label: 'Resolved' },
  { value: 'CLOSED', label: 'Closed' },
]

export default function CasesList() {
  const [searchParams, setSearchParams] = useSearchParams()
  const statusFilter = searchParams.get('status') || ''
  const [search, setSearch] = useState('')

  const { data: cases, isLoading } = useQuery({
    queryKey: ['cases', statusFilter],
    queryFn: () => {
      if (statusFilter) {
        return caseApi.getByStatus(statusFilter).then(res => res.data)
      }
      return caseApi.getOpenCases().then(res => res.data)
    },
  })

  const filteredCases = cases?.filter(c => 
    !search || 
    c.caseNumber?.toLowerCase().includes(search.toLowerCase()) ||
    c.studentSId?.toString().includes(search)
  )

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Recovery Cases</h1>
          <p className="text-gray-500 mt-1">Manage student recovery cases</p>
        </div>
        <Link to="/students" className="btn btn-primary">
          <Plus className="w-4 h-4 mr-2" />
          New Case
        </Link>
      </div>

      {/* Filters */}
      <div className="card">
        <div className="card-body">
          <div className="flex flex-col md:flex-row gap-4">
            <div className="flex-1 relative">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
              <input
                type="text"
                placeholder="Search by case number or student ID..."
                className="input pl-10"
                value={search}
                onChange={(e) => setSearch(e.target.value)}
              />
            </div>
            <div className="flex items-center gap-2">
              <Filter className="w-4 h-4 text-gray-400" />
              <select
                className="input w-auto"
                value={statusFilter}
                onChange={(e) => setSearchParams(e.target.value ? { status: e.target.value } : {})}
              >
                {statusOptions.map(opt => (
                  <option key={opt.value} value={opt.value}>{opt.label}</option>
                ))}
              </select>
            </div>
          </div>
        </div>
      </div>

      {/* Cases Table */}
      <div className="card">
        <div className="overflow-x-auto">
          {isLoading ? (
            <div className="p-8 text-center text-gray-500">Loading cases...</div>
          ) : filteredCases?.length === 0 ? (
            <div className="p-8 text-center text-gray-500">
              No cases found. Create a new case from the Students page.
            </div>
          ) : (
            <table className="table">
              <thead>
                <tr>
                  <th>Case Number</th>
                  <th>Student ID</th>
                  <th>Status</th>
                  <th>Scholarship %</th>
                  <th>Due Amount</th>
                  <th>Assigned To</th>
                  <th>Last Updated</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {filteredCases?.map((caseItem) => (
                  <tr key={caseItem.id}>
                    <td>
                      <Link 
                        to={`/cases/${caseItem.id}`}
                        className="text-primary-600 hover:text-primary-700 font-medium"
                      >
                        {caseItem.caseNumber}
                      </Link>
                    </td>
                    <td>{caseItem.studentSId}</td>
                    <td>
                      <StatusBadge status={caseItem.status} />
                    </td>
                    <td>{caseItem.originalScholarshipPercentage || '-'}%</td>
                    <td className="font-medium">
                      Rs. {(caseItem.currentCalculatedDue || 0).toLocaleString()}
                    </td>
                    <td>{caseItem.assignedOfficer?.fullName || '-'}</td>
                    <td className="text-gray-500">
                      {new Date(caseItem.updatedAt).toLocaleDateString()}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
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
    <span className={`badge ${styles[status] || styles.OPEN}`}>
      {status?.replace('_', ' ')}
    </span>
  )
}
