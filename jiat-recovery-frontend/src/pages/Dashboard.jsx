import { useQuery } from '@tanstack/react-query'
import { Link } from 'react-router-dom'
import { 
  FolderOpen, 
  AlertCircle, 
  CheckCircle, 
  Clock,
  TrendingUp,
  Users,
  DollarSign,
  ArrowUpRight,
  ArrowDownRight,
  Activity,
  FileText,
  UserCheck,
  Building2,
  Calendar,
  Target
} from 'lucide-react'
import { 
  LineChart, 
  Line, 
  XAxis, 
  YAxis, 
  CartesianGrid, 
  Tooltip, 
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell,
  BarChart,
  Bar,
  Legend
} from 'recharts'
import { caseApi, dashboardApi } from '../services/api'
import { useAuthStore } from '../store/authStore'

const StatCard = ({ title, value, icon: Icon, color, href, trend, trendValue }) => (
  <Link to={href} className="card hover:shadow-md transition-shadow">
    <div className="card-body">
      <div className="flex items-center justify-between">
        <div>
          <p className="text-sm font-medium text-gray-500">{title}</p>
          <p className="text-2xl font-bold text-gray-900 mt-1">{value}</p>
          {trend && (
            <div className={`flex items-center mt-1 text-xs ${trend === 'up' ? 'text-success-500' : 'text-danger-500'}`}>
              {trend === 'up' ? <ArrowUpRight className="w-3 h-3" /> : <ArrowDownRight className="w-3 h-3" />}
              <span>{trendValue}</span>
            </div>
          )}
        </div>
        <div className={`p-3 rounded-lg ${color}`}>
          <Icon className="w-6 h-6 text-white" />
        </div>
      </div>
    </div>
  </Link>
)

// Chart colors
const COLORS = ['#3b82f6', '#f59e0b', '#ef4444', '#22c55e', '#8b5cf6']

// Mock data for charts (replace with real API data)
const monthlyTrendData = [
  { month: 'Jul', collected: 2400000, target: 3000000 },
  { month: 'Aug', collected: 3200000, target: 3000000 },
  { month: 'Sep', collected: 2800000, target: 3000000 },
  { month: 'Oct', collected: 3500000, target: 3500000 },
  { month: 'Nov', collected: 4100000, target: 3500000 },
  { month: 'Dec', collected: 2900000, target: 4000000 },
]

const topOutstandingData = [
  { name: 'BSc Computing', amount: 12500000 },
  { name: 'BSc Networking', amount: 8700000 },
  { name: 'BSc Software Eng', amount: 6200000 },
  { name: 'HND Computing', amount: 4800000 },
  { name: 'Diploma IT', amount: 3100000 },
]

export default function Dashboard() {
  const { user } = useAuthStore()
  
  const { data: openCases, isLoading } = useQuery({
    queryKey: ['openCases'],
    queryFn: () => caseApi.getOpenCases().then(res => res.data),
  })

  const stats = {
    open: openCases?.filter(c => c.status === 'OPEN').length || 0,
    inProgress: openCases?.filter(c => c.status === 'IN_PROGRESS').length || 0,
    disputed: openCases?.filter(c => c.status === 'DISPUTED').length || 0,
    resolved: openCases?.filter(c => c.status === 'RESOLVED').length || 0,
    total: openCases?.length || 0,
  }

  const totalDue = openCases?.reduce((sum, c) => sum + (c.currentCalculatedDue || 0), 0) || 0
  
  // Mock KPI data (replace with real API)
  const kpis = {
    thisMonthCollected: 4250000,
    lastMonthCollected: 3800000,
    recoveryRate: 68.5,
    avgResolutionDays: 12,
    pendingGrievances: 8,
    unmatchedDeposits: 15,
  }

  // Case status distribution for pie chart
  const statusDistribution = [
    { name: 'Open', value: stats.open, color: '#3b82f6' },
    { name: 'In Progress', value: stats.inProgress, color: '#f59e0b' },
    { name: 'Disputed', value: stats.disputed, color: '#ef4444' },
    { name: 'Resolved', value: stats.resolved, color: '#22c55e' },
  ].filter(item => item.value > 0)

  // Mock activity feed
  const recentActivity = [
    { id: 1, type: 'calculation', message: 'Calculation completed for REC-2024-0045', time: '5 min ago', icon: Activity },
    { id: 2, type: 'payment', message: 'Payment matched: Rs. 125,000 to Student 200300102947', time: '15 min ago', icon: CheckCircle },
    { id: 3, type: 'case', message: 'New case created: REC-2024-0046', time: '1 hour ago', icon: FolderOpen },
    { id: 4, type: 'grievance', message: 'Grievance submitted by Student 200300103521', time: '2 hours ago', icon: AlertCircle },
    { id: 5, type: 'report', message: 'Monthly report generated successfully', time: '3 hours ago', icon: FileText },
  ]

  // My assigned cases (for officer workload)
  const myCases = openCases?.filter(c => c.assignedOfficerId === user?.id) || []

  return (
    <div className="space-y-6">
      {/* Header with greeting */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">
            Welcome back, {user?.fullName?.split(' ')[0] || 'Officer'}
          </h1>
          <p className="text-gray-500 mt-1">Here's what's happening with recovery today</p>
        </div>
        <div className="text-right">
          <p className="text-sm text-gray-500">{new Date().toLocaleDateString('en-US', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}</p>
        </div>
      </div>

      {/* Primary Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard 
          title="Open Cases" 
          value={stats.open}
          icon={FolderOpen}
          color="bg-primary-500"
          href="/cases?status=OPEN"
          trend="up"
          trendValue="+3 this week"
        />
        <StatCard 
          title="In Progress" 
          value={stats.inProgress}
          icon={Clock}
          color="bg-warning-500"
          href="/cases?status=IN_PROGRESS"
        />
        <StatCard 
          title="Disputed" 
          value={stats.disputed}
          icon={AlertCircle}
          color="bg-danger-500"
          href="/cases?status=DISPUTED"
          trend={stats.disputed > 5 ? 'up' : 'down'}
          trendValue={stats.disputed > 5 ? 'Needs attention' : 'Under control'}
        />
        <StatCard 
          title="Total Outstanding" 
          value={`Rs. ${(totalDue / 1000000).toFixed(1)}M`}
          icon={DollarSign}
          color="bg-success-500"
          href="/reports/outstanding"
        />
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div className="card">
          <div className="card-body">
            <div className="flex items-center space-x-3">
              <div className="p-2 bg-success-50 rounded-lg">
                <TrendingUp className="w-5 h-5 text-success-500" />
              </div>
              <div>
                <p className="text-xs text-gray-500">This Month Collected</p>
                <p className="text-lg font-bold text-gray-900">Rs. {(kpis.thisMonthCollected / 1000000).toFixed(2)}M</p>
                <p className="text-xs text-success-500">
                  +{(((kpis.thisMonthCollected - kpis.lastMonthCollected) / kpis.lastMonthCollected) * 100).toFixed(1)}% vs last month
                </p>
              </div>
            </div>
          </div>
        </div>
        
        <div className="card">
          <div className="card-body">
            <div className="flex items-center space-x-3">
              <div className="p-2 bg-primary-50 rounded-lg">
                <Target className="w-5 h-5 text-primary-500" />
              </div>
              <div>
                <p className="text-xs text-gray-500">Recovery Rate</p>
                <p className="text-lg font-bold text-gray-900">{kpis.recoveryRate}%</p>
                <div className="w-full bg-gray-200 rounded-full h-1.5 mt-1">
                  <div className="bg-primary-500 h-1.5 rounded-full" style={{ width: `${kpis.recoveryRate}%` }}></div>
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div className="card">
          <div className="card-body">
            <div className="flex items-center space-x-3">
              <div className="p-2 bg-warning-50 rounded-lg">
                <Calendar className="w-5 h-5 text-warning-500" />
              </div>
              <div>
                <p className="text-xs text-gray-500">Avg Resolution Time</p>
                <p className="text-lg font-bold text-gray-900">{kpis.avgResolutionDays} days</p>
                <p className="text-xs text-gray-500">Target: 14 days</p>
              </div>
            </div>
          </div>
        </div>
        
        <div className="card">
          <div className="card-body">
            <div className="flex items-center space-x-3">
              <div className="p-2 bg-danger-50 rounded-lg">
                <Building2 className="w-5 h-5 text-danger-500" />
              </div>
              <div>
                <p className="text-xs text-gray-500">Unmatched Deposits</p>
                <p className="text-lg font-bold text-gray-900">{kpis.unmatchedDeposits}</p>
                <Link to="/reconciliation" className="text-xs text-primary-600 hover:underline">
                  Review now →
                </Link>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Charts Row */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Recovery Trend Chart */}
        <div className="card">
          <div className="card-header">
            <h2 className="text-lg font-semibold text-gray-900">Recovery Trend</h2>
            <p className="text-sm text-gray-500">Monthly collection vs target</p>
          </div>
          <div className="card-body">
            <div className="h-64">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={monthlyTrendData}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                  <XAxis dataKey="month" stroke="#6b7280" fontSize={12} />
                  <YAxis 
                    stroke="#6b7280" 
                    fontSize={12}
                    tickFormatter={(value) => `${(value / 1000000).toFixed(1)}M`}
                  />
                  <Tooltip 
                    formatter={(value) => [`Rs. ${value.toLocaleString()}`, '']}
                    contentStyle={{ borderRadius: '8px', border: '1px solid #e5e7eb' }}
                  />
                  <Legend />
                  <Line 
                    type="monotone" 
                    dataKey="collected" 
                    stroke="#3b82f6" 
                    strokeWidth={2}
                    dot={{ fill: '#3b82f6' }}
                    name="Collected"
                  />
                  <Line 
                    type="monotone" 
                    dataKey="target" 
                    stroke="#9ca3af" 
                    strokeWidth={2}
                    strokeDasharray="5 5"
                    dot={false}
                    name="Target"
                  />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        {/* Case Status Distribution */}
        <div className="card">
          <div className="card-header">
            <h2 className="text-lg font-semibold text-gray-900">Case Status Distribution</h2>
            <p className="text-sm text-gray-500">Current case breakdown</p>
          </div>
          <div className="card-body">
            <div className="h-64 flex items-center justify-center">
              {statusDistribution.length > 0 ? (
                <ResponsiveContainer width="100%" height="100%">
                  <PieChart>
                    <Pie
                      data={statusDistribution}
                      cx="50%"
                      cy="50%"
                      innerRadius={60}
                      outerRadius={90}
                      paddingAngle={2}
                      dataKey="value"
                    >
                      {statusDistribution.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={entry.color} />
                      ))}
                    </Pie>
                    <Tooltip 
                      formatter={(value, name) => [value, name]}
                      contentStyle={{ borderRadius: '8px', border: '1px solid #e5e7eb' }}
                    />
                    <Legend />
                  </PieChart>
                </ResponsiveContainer>
              ) : (
                <p className="text-gray-500">No case data available</p>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* Outstanding by Course Chart */}
      <div className="card">
        <div className="card-header">
          <h2 className="text-lg font-semibold text-gray-900">Outstanding by Course</h2>
          <p className="text-sm text-gray-500">Top 5 courses with highest outstanding amounts</p>
        </div>
        <div className="card-body">
          <div className="h-64">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={topOutstandingData} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                <XAxis 
                  type="number" 
                  stroke="#6b7280" 
                  fontSize={12}
                  tickFormatter={(value) => `${(value / 1000000).toFixed(0)}M`}
                />
                <YAxis 
                  type="category" 
                  dataKey="name" 
                  stroke="#6b7280" 
                  fontSize={12}
                  width={120}
                />
                <Tooltip 
                  formatter={(value) => [`Rs. ${value.toLocaleString()}`, 'Outstanding']}
                  contentStyle={{ borderRadius: '8px', border: '1px solid #e5e7eb' }}
                />
                <Bar dataKey="amount" fill="#3b82f6" radius={[0, 4, 4, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>

      {/* Bottom Row: Recent Cases, Activity Feed, My Workload */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Recent Cases */}
        <div className="lg:col-span-2 card">
          <div className="card-header flex items-center justify-between">
            <h2 className="text-lg font-semibold text-gray-900">Recent Cases</h2>
            <Link to="/cases" className="text-sm text-primary-600 hover:text-primary-700">
              View all →
            </Link>
          </div>
          <div className="overflow-x-auto">
            {isLoading ? (
              <div className="p-8 text-center text-gray-500">Loading...</div>
            ) : openCases?.length === 0 ? (
              <div className="p-8 text-center text-gray-500">No open cases</div>
            ) : (
              <table className="table">
                <thead>
                  <tr>
                    <th>Case Number</th>
                    <th>Student ID</th>
                    <th>Status</th>
                    <th>Due Amount</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-200">
                  {openCases?.slice(0, 5).map((caseItem) => (
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
                      <td className="font-medium">
                        Rs. {(caseItem.currentCalculatedDue || 0).toLocaleString()}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            )}
          </div>
        </div>

        {/* Activity Feed */}
        <div className="card">
          <div className="card-header">
            <h2 className="text-lg font-semibold text-gray-900">Recent Activity</h2>
          </div>
          <div className="divide-y divide-gray-100">
            {recentActivity.map((activity) => (
              <div key={activity.id} className="p-4 flex items-start space-x-3">
                <div className={`p-2 rounded-lg ${
                  activity.type === 'payment' ? 'bg-success-50' :
                  activity.type === 'grievance' ? 'bg-danger-50' :
                  activity.type === 'calculation' ? 'bg-primary-50' :
                  'bg-gray-50'
                }`}>
                  <activity.icon className={`w-4 h-4 ${
                    activity.type === 'payment' ? 'text-success-500' :
                    activity.type === 'grievance' ? 'text-danger-500' :
                    activity.type === 'calculation' ? 'text-primary-500' :
                    'text-gray-500'
                  }`} />
                </div>
                <div className="flex-1 min-w-0">
                  <p className="text-sm text-gray-900 truncate">{activity.message}</p>
                  <p className="text-xs text-gray-500">{activity.time}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* My Workload & Quick Actions */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* My Assigned Cases */}
        <div className="card">
          <div className="card-header flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <UserCheck className="w-5 h-5 text-primary-500" />
              <h2 className="text-lg font-semibold text-gray-900">My Assigned Cases</h2>
            </div>
            <span className="badge badge-primary">{myCases.length} cases</span>
          </div>
          <div className="divide-y divide-gray-100">
            {myCases.length === 0 ? (
              <div className="p-8 text-center text-gray-500">
                No cases assigned to you
              </div>
            ) : (
              myCases.slice(0, 4).map((caseItem) => (
                <Link 
                  key={caseItem.id}
                  to={`/cases/${caseItem.id}`}
                  className="p-4 flex items-center justify-between hover:bg-gray-50"
                >
                  <div>
                    <p className="font-medium text-gray-900">{caseItem.caseNumber}</p>
                    <p className="text-sm text-gray-500">Due: Rs. {(caseItem.currentCalculatedDue || 0).toLocaleString()}</p>
                  </div>
                  <StatusBadge status={caseItem.status} />
                </Link>
              ))
            )}
          </div>
          {myCases.length > 4 && (
            <div className="p-4 border-t border-gray-100">
              <Link to="/cases?assigned=me" className="text-sm text-primary-600 hover:text-primary-700">
                View all {myCases.length} cases →
              </Link>
            </div>
          )}
        </div>

        {/* Quick Actions */}
        <div className="card">
          <div className="card-header">
            <h2 className="text-lg font-semibold text-gray-900">Quick Actions</h2>
          </div>
          <div className="card-body">
            <div className="grid grid-cols-2 gap-4">
              <Link 
                to="/students" 
                className="flex flex-col items-center p-4 rounded-lg border border-gray-200 hover:border-primary-300 hover:bg-primary-50 transition-colors text-center"
              >
                <Users className="w-8 h-8 text-primary-600 mb-2" />
                <p className="font-medium text-gray-900 text-sm">Search Student</p>
              </Link>
              <Link 
                to="/reconciliation" 
                className="flex flex-col items-center p-4 rounded-lg border border-gray-200 hover:border-primary-300 hover:bg-primary-50 transition-colors text-center"
              >
                <Building2 className="w-8 h-8 text-primary-600 mb-2" />
                <p className="font-medium text-gray-900 text-sm">Bank Reconciliation</p>
              </Link>
              <Link 
                to="/reports" 
                className="flex flex-col items-center p-4 rounded-lg border border-gray-200 hover:border-primary-300 hover:bg-primary-50 transition-colors text-center"
              >
                <FileText className="w-8 h-8 text-primary-600 mb-2" />
                <p className="font-medium text-gray-900 text-sm">Generate Report</p>
              </Link>
              <Link 
                to="/grievances" 
                className="flex flex-col items-center p-4 rounded-lg border border-gray-200 hover:border-primary-300 hover:bg-primary-50 transition-colors text-center"
              >
                <AlertCircle className="w-8 h-8 text-primary-600 mb-2" />
                <p className="font-medium text-gray-900 text-sm">View Grievances</p>
              </Link>
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
    <span className={`badge ${styles[status] || styles.OPEN}`}>
      {status?.replace('_', ' ')}
    </span>
  )
}
