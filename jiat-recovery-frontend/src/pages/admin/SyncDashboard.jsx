import { useState } from 'react'
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { 
  RefreshCw, 
  CheckCircle, 
  XCircle, 
  Clock, 
  Database,
  Activity,
  Server,
  Play,
  AlertTriangle,
  Wifi,
  WifiOff
} from 'lucide-react'
import { syncApi } from '../../services/api'

export default function SyncDashboard() {
  const queryClient = useQueryClient()
  const [syncInProgress, setSyncInProgress] = useState(false)

  // Fetch sync status
  const { data: syncStatus, isLoading: statusLoading, refetch: refetchStatus } = useQuery({
    queryKey: ['sync-status'],
    queryFn: () => syncApi.getStatus().then(res => res.data),
    refetchInterval: 30000, // Refresh every 30 seconds
  })

  // Fetch sync history
  const { data: syncHistory, isLoading: historyLoading } = useQuery({
    queryKey: ['sync-history'],
    queryFn: () => syncApi.getHistory(10).then(res => res.data),
  })

  // Full sync mutation
  const fullSyncMutation = useMutation({
    mutationFn: () => syncApi.triggerFullSync(),
    onMutate: () => setSyncInProgress(true),
    onSuccess: () => {
      queryClient.invalidateQueries(['sync-status'])
      queryClient.invalidateQueries(['sync-history'])
    },
    onSettled: () => setSyncInProgress(false),
  })

  // Incremental sync mutation
  const incrementalSyncMutation = useMutation({
    mutationFn: () => syncApi.triggerIncrementalSync(),
    onMutate: () => setSyncInProgress(true),
    onSuccess: () => {
      queryClient.invalidateQueries(['sync-status'])
      queryClient.invalidateQueries(['sync-history'])
    },
    onSettled: () => setSyncInProgress(false),
  })

  const formatDateTime = (dateString) => {
    if (!dateString) return 'N/A'
    return new Date(dateString).toLocaleString('en-GB', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit'
    })
  }

  const formatDuration = (ms) => {
    if (!ms) return 'N/A'
    if (ms < 1000) return `${ms}ms`
    return `${(ms / 1000).toFixed(2)}s`
  }

  const getStatusBadge = (status) => {
    switch (status) {
      case 'SUCCESS':
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"><CheckCircle className="w-3 h-3 mr-1" /> Success</span>
      case 'FAILED':
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800"><XCircle className="w-3 h-3 mr-1" /> Failed</span>
      case 'IN_PROGRESS':
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"><RefreshCw className="w-3 h-3 mr-1 animate-spin" /> In Progress</span>
      default:
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">{status}</span>
    }
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Data Sync Dashboard</h1>
          <p className="text-gray-500">Synchronize financial data from Java Institute</p>
        </div>
        <button
          onClick={() => refetchStatus()}
          className="btn btn-secondary"
          disabled={statusLoading}
        >
          <RefreshCw className={`w-4 h-4 mr-2 ${statusLoading ? 'animate-spin' : ''}`} />
          Refresh
        </button>
      </div>

      {/* API Status Card */}
      <div className="card">
        <div className="card-header">
          <h2 className="text-lg font-semibold flex items-center">
            <Server className="w-5 h-5 mr-2 text-blue-600" />
            Java Institute API Status
          </h2>
        </div>
        <div className="card-body">
          {statusLoading ? (
            <div className="flex items-center justify-center py-8">
              <RefreshCw className="w-6 h-6 animate-spin text-blue-600" />
              <span className="ml-2">Checking API status...</span>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {/* Connection Status */}
              <div className={`p-4 rounded-lg border-2 ${syncStatus?.status === 'UP' ? 'border-green-200 bg-green-50' : 'border-red-200 bg-red-50'}`}>
                <div className="flex items-center">
                  {syncStatus?.status === 'UP' ? (
                    <Wifi className="w-8 h-8 text-green-600" />
                  ) : (
                    <WifiOff className="w-8 h-8 text-red-600" />
                  )}
                  <div className="ml-3">
                    <p className="text-sm text-gray-500">Connection</p>
                    <p className={`text-lg font-bold ${syncStatus?.status === 'UP' ? 'text-green-700' : 'text-red-700'}`}>
                      {syncStatus?.status === 'UP' ? 'Connected' : 'Disconnected'}
                    </p>
                  </div>
                </div>
              </div>

              {/* API URL */}
              <div className="p-4 rounded-lg border border-gray-200 bg-gray-50">
                <div className="flex items-center">
                  <Database className="w-8 h-8 text-blue-600" />
                  <div className="ml-3">
                    <p className="text-sm text-gray-500">API Endpoint</p>
                    <p className="text-sm font-mono text-gray-700 truncate">{syncStatus?.apiUrl || 'N/A'}</p>
                  </div>
                </div>
              </div>

              {/* Last Sync */}
              <div className="p-4 rounded-lg border border-gray-200 bg-gray-50">
                <div className="flex items-center">
                  <Clock className="w-8 h-8 text-purple-600" />
                  <div className="ml-3">
                    <p className="text-sm text-gray-500">Last Sync</p>
                    <p className="text-sm font-medium text-gray-700">
                      {syncStatus?.lastSync ? formatDateTime(syncStatus.lastSync.syncTime) : 'Never'}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Sync Actions */}
      <div className="card">
        <div className="card-header">
          <h2 className="text-lg font-semibold flex items-center">
            <Activity className="w-5 h-5 mr-2 text-green-600" />
            Sync Actions
          </h2>
        </div>
        <div className="card-body">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {/* Full Sync */}
            <div className="p-6 border-2 border-dashed border-blue-200 rounded-lg bg-blue-50">
              <h3 className="text-lg font-semibold text-blue-800 mb-2">Full Sync</h3>
              <p className="text-sm text-blue-600 mb-4">
                Fetches all data from Java Institute including students, enrollments, fee structures, payments, and offers.
                Use this for initial setup or to refresh all data.
              </p>
              <button
                onClick={() => fullSyncMutation.mutate()}
                disabled={syncInProgress || syncStatus?.status !== 'UP'}
                className="btn btn-primary w-full"
              >
                {fullSyncMutation.isPending ? (
                  <>
                    <RefreshCw className="w-4 h-4 mr-2 animate-spin" />
                    Syncing...
                  </>
                ) : (
                  <>
                    <Play className="w-4 h-4 mr-2" />
                    Start Full Sync
                  </>
                )}
              </button>
              {fullSyncMutation.isSuccess && (
                <div className="mt-3 p-2 bg-green-100 rounded text-sm text-green-700">
                  ✓ Full sync completed! Records: {fullSyncMutation.data?.data?.totalRecords || 0}
                </div>
              )}
              {fullSyncMutation.isError && (
                <div className="mt-3 p-2 bg-red-100 rounded text-sm text-red-700">
                  ✗ Sync failed: {fullSyncMutation.error?.message}
                </div>
              )}
            </div>

            {/* Incremental Sync */}
            <div className="p-6 border-2 border-dashed border-green-200 rounded-lg bg-green-50">
              <h3 className="text-lg font-semibold text-green-800 mb-2">Incremental Sync</h3>
              <p className="text-sm text-green-600 mb-4">
                Fetches only new or updated records since the last sync.
                Use this for regular updates to minimize data transfer.
              </p>
              <button
                onClick={() => incrementalSyncMutation.mutate()}
                disabled={syncInProgress || syncStatus?.status !== 'UP'}
                className="btn btn-success w-full"
              >
                {incrementalSyncMutation.isPending ? (
                  <>
                    <RefreshCw className="w-4 h-4 mr-2 animate-spin" />
                    Syncing...
                  </>
                ) : (
                  <>
                    <RefreshCw className="w-4 h-4 mr-2" />
                    Start Incremental Sync
                  </>
                )}
              </button>
              {incrementalSyncMutation.isSuccess && (
                <div className="mt-3 p-2 bg-green-100 rounded text-sm text-green-700">
                  ✓ Incremental sync completed! Records: {incrementalSyncMutation.data?.data?.totalRecords || 0}
                </div>
              )}
              {incrementalSyncMutation.isError && (
                <div className="mt-3 p-2 bg-red-100 rounded text-sm text-red-700">
                  ✗ Sync failed: {incrementalSyncMutation.error?.message}
                </div>
              )}
            </div>
          </div>

          {syncStatus?.status !== 'UP' && (
            <div className="mt-4 p-4 bg-amber-50 border border-amber-200 rounded-lg flex items-start">
              <AlertTriangle className="w-5 h-5 text-amber-600 mr-3 mt-0.5" />
              <div>
                <p className="font-medium text-amber-800">API Connection Required</p>
                <p className="text-sm text-amber-600">
                  Cannot sync data because the Java Institute API is not reachable. 
                  Please ensure the API server is running and accessible.
                </p>
              </div>
            </div>
          )}
        </div>
      </div>

      {/* Sync History */}
      <div className="card">
        <div className="card-header">
          <h2 className="text-lg font-semibold flex items-center">
            <Clock className="w-5 h-5 mr-2 text-purple-600" />
            Sync History
          </h2>
        </div>
        <div className="card-body p-0">
          {historyLoading ? (
            <div className="flex items-center justify-center py-8">
              <RefreshCw className="w-6 h-6 animate-spin text-blue-600" />
            </div>
          ) : syncHistory && syncHistory.length > 0 ? (
            <div className="overflow-x-auto">
              <table className="min-w-full divide-y divide-gray-200">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Time</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Records</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Duration</th>
                    <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Triggered By</th>
                  </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                  {syncHistory.map((log, index) => (
                    <tr key={log.id || index} className="hover:bg-gray-50">
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                        {formatDateTime(log.syncTime)}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm">
                        <span className={`px-2 py-1 rounded text-xs font-medium ${
                          log.syncType === 'FULL' ? 'bg-blue-100 text-blue-800' : 'bg-green-100 text-green-800'
                        }`}>
                          {log.syncType}
                        </span>
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap">
                        {getStatusBadge(log.status)}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        {log.recordsSynced || 0}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        {formatDuration(log.durationMs)}
                      </td>
                      <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        {log.triggeredBy || 'N/A'}
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ) : (
            <div className="flex flex-col items-center justify-center py-12 text-gray-500">
              <Database className="w-12 h-12 mb-3 text-gray-300" />
              <p>No sync history available</p>
              <p className="text-sm">Run a sync to see history here</p>
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
