import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import { MessageSquare, Clock, CheckCircle, XCircle } from 'lucide-react'
import { grievanceApi } from '../../services/api'

export default function GrievancesList() {
  const { data: grievances, isLoading } = useQuery({
    queryKey: ['grievances'],
    queryFn: () => grievanceApi.getPending().then(res => res.data),
  })

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Grievances</h1>
        <p className="text-gray-500 mt-1">Manage student disputes and complaints</p>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <StatCard 
          title="Submitted" 
          value={grievances?.filter(g => g.status === 'SUBMITTED').length || 0}
          icon={MessageSquare}
          color="bg-primary-500"
        />
        <StatCard 
          title="Under Review" 
          value={grievances?.filter(g => g.status === 'UNDER_REVIEW').length || 0}
          icon={Clock}
          color="bg-warning-500"
        />
        <StatCard 
          title="Resolved" 
          value={grievances?.filter(g => g.status === 'RESOLVED').length || 0}
          icon={CheckCircle}
          color="bg-success-500"
        />
        <StatCard 
          title="Rejected" 
          value={grievances?.filter(g => g.status === 'REJECTED').length || 0}
          icon={XCircle}
          color="bg-danger-500"
        />
      </div>

      {/* Grievances Table */}
      <div className="card">
        <div className="card-header">
          <h2 className="text-lg font-semibold">Pending Grievances</h2>
        </div>
        <div className="overflow-x-auto">
          {isLoading ? (
            <div className="p-8 text-center text-gray-500">Loading...</div>
          ) : grievances?.length === 0 ? (
            <div className="p-8 text-center text-gray-500">
              No pending grievances
            </div>
          ) : (
            <table className="table">
              <thead>
                <tr>
                  <th>Grievance #</th>
                  <th>Student</th>
                  <th>Subject</th>
                  <th>Priority</th>
                  <th>Status</th>
                  <th>Submitted</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {grievances?.map((grievance) => (
                  <tr key={grievance.id}>
                    <td className="font-medium">{grievance.grievanceNumber}</td>
                    <td>{grievance.studentSId}</td>
                    <td className="max-w-xs truncate">{grievance.subject}</td>
                    <td>
                      <PriorityBadge priority={grievance.priority} />
                    </td>
                    <td>
                      <StatusBadge status={grievance.status} />
                    </td>
                    <td className="text-gray-500">
                      {new Date(grievance.createdAt).toLocaleDateString()}
                    </td>
                    <td>
                      <Link
                        to={`/grievances/${grievance.id}`}
                        className="text-primary-600 hover:text-primary-700 text-sm font-medium"
                      >
                        View
                      </Link>
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

function StatCard({ title, value, icon: Icon, color }) {
  return (
    <div className="card">
      <div className="card-body">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm font-medium text-gray-500">{title}</p>
            <p className="text-2xl font-bold text-gray-900 mt-1">{value}</p>
          </div>
          <div className={`p-3 rounded-lg ${color}`}>
            <Icon className="w-6 h-6 text-white" />
          </div>
        </div>
      </div>
    </div>
  )
}

function StatusBadge({ status }) {
  const styles = {
    SUBMITTED: 'badge-primary',
    UNDER_REVIEW: 'badge-warning',
    RESOLVED: 'badge-success',
    REJECTED: 'badge-danger',
  }
  
  return (
    <span className={`badge ${styles[status] || styles.SUBMITTED}`}>
      {status?.replace('_', ' ')}
    </span>
  )
}

function PriorityBadge({ priority }) {
  const styles = {
    LOW: 'bg-gray-100 text-gray-700',
    MEDIUM: 'bg-warning-50 text-warning-700',
    HIGH: 'bg-danger-50 text-danger-700',
  }
  
  return (
    <span className={`badge ${styles[priority] || styles.MEDIUM}`}>
      {priority}
    </span>
  )
}
