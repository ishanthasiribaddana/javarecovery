import { useState, useEffect } from 'react'
import { scholarshipApi } from '../services/api'

const ScholarshipAlertBoard = () => {
  const [warnings, setWarnings] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    fetchWarnings()
    // Refresh every 5 minutes
    const interval = setInterval(fetchWarnings, 5 * 60 * 1000)
    return () => clearInterval(interval)
  }, [])

  const fetchWarnings = async () => {
    try {
      setLoading(true)
      const response = await scholarshipApi.getWarnings()
      setWarnings(response.data || [])
      setError(null)
    } catch (err) {
      console.error('Error fetching scholarship warnings:', err)
      setError('Failed to load scholarship warnings')
    } finally {
      setLoading(false)
    }
  }

  const getWarningColor = (daysRemaining) => {
    if (daysRemaining <= 3) return 'bg-red-100 border-red-500 text-red-800'
    if (daysRemaining <= 7) return 'bg-orange-100 border-orange-500 text-orange-800'
    return 'bg-yellow-100 border-yellow-500 text-yellow-800'
  }

  const getCountdownDisplay = (daysRemaining) => {
    if (daysRemaining <= 0) return { text: 'EXPIRED', class: 'text-red-600 animate-pulse' }
    if (daysRemaining === 1) return { text: '1 day', class: 'text-red-600 font-bold' }
    if (daysRemaining <= 3) return { text: `${daysRemaining} days`, class: 'text-red-600 font-bold' }
    if (daysRemaining <= 7) return { text: `${daysRemaining} days`, class: 'text-orange-600 font-semibold' }
    return { text: `${daysRemaining} days`, class: 'text-yellow-700' }
  }

  if (loading && warnings.length === 0) {
    return (
      <div className="bg-white rounded-lg shadow-md p-4">
        <div className="animate-pulse flex space-x-4">
          <div className="flex-1 space-y-4 py-1">
            <div className="h-4 bg-gray-200 rounded w-3/4"></div>
            <div className="space-y-2">
              <div className="h-4 bg-gray-200 rounded"></div>
              <div className="h-4 bg-gray-200 rounded w-5/6"></div>
            </div>
          </div>
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 rounded-lg p-4">
        <p className="text-red-600">{error}</p>
        <button 
          onClick={fetchWarnings}
          className="mt-2 text-sm text-red-700 underline hover:no-underline"
        >
          Retry
        </button>
      </div>
    )
  }

  if (warnings.length === 0) {
    return (
      <div className="bg-green-50 border border-green-200 rounded-lg p-4">
        <div className="flex items-center">
          <span className="text-2xl mr-3">✅</span>
          <div>
            <h3 className="font-semibold text-green-800">No Scholarship Warnings</h3>
            <p className="text-sm text-green-600">All students are up to date with their payments</p>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden">
      <div className="bg-gradient-to-r from-amber-500 to-orange-500 px-4 py-3">
        <div className="flex items-center justify-between">
          <div className="flex items-center">
            <span className="text-2xl mr-2">⚠️</span>
            <h2 className="text-lg font-bold text-white">Scholarship Alert Board</h2>
          </div>
          <span className="bg-white text-orange-600 px-3 py-1 rounded-full text-sm font-bold">
            {warnings.length} Warning{warnings.length !== 1 ? 's' : ''}
          </span>
        </div>
      </div>
      
      <div className="divide-y divide-gray-100 max-h-96 overflow-y-auto">
        {warnings.map((warning, index) => {
          const countdown = getCountdownDisplay(warning.daysRemaining)
          return (
            <div 
              key={warning.spsId || index}
              className={`p-4 border-l-4 ${getWarningColor(warning.daysRemaining)} hover:bg-opacity-75 transition-colors`}
            >
              <div className="flex justify-between items-start">
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <h3 className="font-semibold text-gray-900">{warning.name}</h3>
                    <span className="text-xs bg-gray-200 px-2 py-0.5 rounded text-gray-600">
                      {warning.nic}
                    </span>
                  </div>
                  <div className="mt-1 text-sm text-gray-600">
                    <span className="font-medium">Current:</span> {warning.currentPercentage}%
                    <span className="mx-2">→</span>
                    <span className="font-medium">Will drop to:</span> {warning.semesterPercentage}%
                  </div>
                  <div className="mt-1 text-xs text-gray-500">
                    Released: {new Date(warning.releaseDate).toLocaleDateString()}
                  </div>
                </div>
                <div className="text-right ml-4">
                  <div className="text-xs text-gray-500 uppercase">Time Left</div>
                  <div className={`text-2xl font-bold ${countdown.class}`}>
                    {countdown.text}
                  </div>
                  {warning.daysRemaining <= 7 && (
                    <div className="mt-1">
                      <CountdownTimer daysRemaining={warning.daysRemaining} />
                    </div>
                  )}
                </div>
              </div>
            </div>
          )
        })}
      </div>
      
      <div className="bg-gray-50 px-4 py-2 text-xs text-gray-500 flex justify-between items-center">
        <span>Auto-refreshes every 5 minutes</span>
        <button 
          onClick={fetchWarnings}
          className="text-blue-600 hover:text-blue-800 underline"
        >
          Refresh now
        </button>
      </div>
    </div>
  )
}

const CountdownTimer = ({ daysRemaining }) => {
  const [timeLeft, setTimeLeft] = useState(calculateTimeLeft(daysRemaining))

  useEffect(() => {
    const timer = setInterval(() => {
      setTimeLeft(calculateTimeLeft(daysRemaining))
    }, 1000)
    return () => clearInterval(timer)
  }, [daysRemaining])

  function calculateTimeLeft(days) {
    const now = new Date()
    const endOfDay = new Date()
    endOfDay.setHours(23, 59, 59, 999)
    
    const totalMs = (days * 24 * 60 * 60 * 1000) + (endOfDay - now)
    
    if (totalMs <= 0) {
      return { hours: 0, minutes: 0, seconds: 0 }
    }
    
    const hours = Math.floor(totalMs / (1000 * 60 * 60))
    const minutes = Math.floor((totalMs % (1000 * 60 * 60)) / (1000 * 60))
    const seconds = Math.floor((totalMs % (1000 * 60)) / 1000)
    
    return { hours, minutes, seconds }
  }

  const pad = (num) => String(num).padStart(2, '0')

  return (
    <div className="font-mono text-xs bg-gray-800 text-white px-2 py-1 rounded">
      {pad(timeLeft.hours)}:{pad(timeLeft.minutes)}:{pad(timeLeft.seconds)}
    </div>
  )
}

export default ScholarshipAlertBoard
