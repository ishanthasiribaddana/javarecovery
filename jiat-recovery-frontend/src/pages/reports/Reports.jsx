import { useState } from 'react'
import { useQuery, useMutation } from '@tanstack/react-query'
import { FileText, Download, Clock, CheckCircle, ChevronRight, AlertTriangle, BarChart3, GitCompare, Calculator } from 'lucide-react'
import { Link } from 'react-router-dom'
import { reportApi } from '../../services/api'
import { useAuthStore } from '../../store/authStore'
import toast from 'react-hot-toast'

export default function Reports() {
  const [selectedTemplate, setSelectedTemplate] = useState(null)
  const [studentId, setStudentId] = useState('')
  const { user } = useAuthStore()

  const { data: templates } = useQuery({
    queryKey: ['reportTemplates'],
    queryFn: () => reportApi.getTemplates().then(res => res.data),
  })

  const { data: history, isLoading: historyLoading } = useQuery({
    queryKey: ['reportHistory'],
    queryFn: () => reportApi.getHistory().then(res => res.data),
  })

  const generateMutation = useMutation({
    mutationFn: ({ templateId, params }) => reportApi.generate(templateId, params),
    onSuccess: () => {
      toast.success('Report generation started!')
    },
    onError: () => toast.error('Failed to generate report'),
  })

  const handleGenerate = () => {
    if (!selectedTemplate) {
      toast.error('Please select a report template')
      return
    }
    generateMutation.mutate({
      templateId: selectedTemplate.id,
      params: {
        studentId: studentId || null,
        generatedBy: user?.id,
        outputFormat: 'PDF',
      },
    })
  }

  const handleDownload = async (reportId) => {
    try {
      const response = await reportApi.download(reportId)
      const url = window.URL.createObjectURL(new Blob([response.data]))
      const link = document.createElement('a')
      link.href = url
      link.setAttribute('download', `report-${reportId}.pdf`)
      document.body.appendChild(link)
      link.click()
      link.remove()
    } catch (error) {
      toast.error('Download failed')
    }
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Reports</h1>
        <p className="text-gray-500 mt-1">Generate financial statements and reports</p>
      </div>

      {/* Quick Access Reports */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <Link 
          to="/reports/outstanding"
          className="bg-white rounded-lg shadow p-4 hover:shadow-md transition-shadow flex items-center justify-between group"
        >
          <div className="flex items-center gap-3">
            <div className="p-2 bg-blue-100 rounded-lg">
              <BarChart3 className="w-5 h-5 text-blue-600" />
            </div>
            <div>
              <p className="font-medium text-gray-900">Outstanding Report</p>
              <p className="text-sm text-gray-500">Students with balances</p>
            </div>
          </div>
          <ChevronRight className="w-5 h-5 text-gray-400 group-hover:text-gray-600" />
        </Link>
        
        <Link 
          to="/reports/overdue-students"
          className="bg-white rounded-lg shadow p-4 hover:shadow-md transition-shadow flex items-center justify-between group"
        >
          <div className="flex items-center gap-3">
            <div className="p-2 bg-red-100 rounded-lg">
              <AlertTriangle className="w-5 h-5 text-red-600" />
            </div>
            <div>
              <p className="font-medium text-gray-900">Overdue Students Report</p>
              <p className="text-sm text-gray-500">Students with overdue payments</p>
            </div>
          </div>
          <ChevronRight className="w-5 h-5 text-gray-400 group-hover:text-gray-600" />
        </Link>
        
        <Link 
          to="/reports/reconciliation"
          className="bg-white rounded-lg shadow p-4 hover:shadow-md transition-shadow flex items-center justify-between group"
        >
          <div className="flex items-center gap-3">
            <div className="p-2 bg-purple-100 rounded-lg">
              <GitCompare className="w-5 h-5 text-purple-600" />
            </div>
            <div>
              <p className="font-medium text-gray-900">Payment Reconciliation</p>
              <p className="text-sm text-gray-500">Compare voucher vs scheduler data</p>
            </div>
          </div>
          <ChevronRight className="w-5 h-5 text-gray-400 group-hover:text-gray-600" />
        </Link>
        
        <Link 
          to="/reports/scholarship-diagnostic"
          className="bg-white rounded-lg shadow p-4 hover:shadow-md transition-shadow flex items-center justify-between group"
        >
          <div className="flex items-center gap-3">
            <div className="p-2 bg-orange-100 rounded-lg">
              <Calculator className="w-5 h-5 text-orange-600" />
            </div>
            <div>
              <p className="font-medium text-gray-900">Scholarship Diagnostic</p>
              <p className="text-sm text-gray-500">Identify calculation mismatches</p>
            </div>
          </div>
          <ChevronRight className="w-5 h-5 text-gray-400 group-hover:text-gray-600" />
        </Link>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Generate Report */}
        <div className="lg:col-span-2">
          <div className="card">
            <div className="card-header">
              <h2 className="text-lg font-semibold">Generate Report</h2>
            </div>
            <div className="card-body space-y-4">
              {/* Template Selection */}
              <div>
                <label className="label">Report Template</label>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  {templates?.map((template) => (
                    <button
                      key={template.id}
                      onClick={() => setSelectedTemplate(template)}
                      className={`p-4 rounded-lg border-2 text-left transition-colors ${
                        selectedTemplate?.id === template.id
                          ? 'border-primary-500 bg-primary-50'
                          : 'border-gray-200 hover:border-gray-300'
                      }`}
                    >
                      <div className="flex items-start space-x-3">
                        <FileText className={`w-5 h-5 mt-0.5 ${
                          selectedTemplate?.id === template.id 
                            ? 'text-primary-600' 
                            : 'text-gray-400'
                        }`} />
                        <div>
                          <p className="font-medium text-gray-900">{template.templateName}</p>
                          <p className="text-sm text-gray-500">{template.description}</p>
                        </div>
                      </div>
                    </button>
                  )) || (
                    <>
                      <TemplateCard 
                        name="Student Financial Statement"
                        description="Detailed payment history and dues"
                        selected={selectedTemplate?.code === 'STUDENT_STATEMENT'}
                        onClick={() => setSelectedTemplate({ id: 1, code: 'STUDENT_STATEMENT', templateName: 'Student Financial Statement' })}
                      />
                      <TemplateCard 
                        name="Recovery Summary Report"
                        description="Overview of all recovery cases"
                        selected={selectedTemplate?.code === 'RECOVERY_SUMMARY'}
                        onClick={() => setSelectedTemplate({ id: 2, code: 'RECOVERY_SUMMARY', templateName: 'Recovery Summary Report' })}
                      />
                      <TemplateCard 
                        name="Outstanding Dues Report"
                        description="List of students with pending dues"
                        selected={selectedTemplate?.code === 'OUTSTANDING_DUES'}
                        onClick={() => setSelectedTemplate({ id: 3, code: 'OUTSTANDING_DUES', templateName: 'Outstanding Dues Report' })}
                      />
                      <TemplateCard 
                        name="Payment Collection Report"
                        description="Summary of payments received"
                        selected={selectedTemplate?.code === 'PAYMENT_COLLECTION'}
                        onClick={() => setSelectedTemplate({ id: 4, code: 'PAYMENT_COLLECTION', templateName: 'Payment Collection Report' })}
                      />
                    </>
                  )}
                </div>
              </div>

              {/* Parameters */}
              {selectedTemplate?.code === 'STUDENT_STATEMENT' && (
                <div>
                  <label className="label">Student ID (optional)</label>
                  <input
                    type="text"
                    className="input"
                    placeholder="Enter student ID for individual statement"
                    value={studentId}
                    onChange={(e) => setStudentId(e.target.value)}
                  />
                </div>
              )}

              <button
                onClick={handleGenerate}
                disabled={!selectedTemplate || generateMutation.isPending}
                className="btn btn-primary"
              >
                {generateMutation.isPending ? 'Generating...' : 'Generate Report'}
              </button>
            </div>
          </div>
        </div>

        {/* Recent Reports */}
        <div>
          <div className="card">
            <div className="card-header">
              <h2 className="text-lg font-semibold">Recent Reports</h2>
            </div>
            <div className="divide-y divide-gray-200">
              {historyLoading ? (
                <div className="p-4 text-center text-gray-500">Loading...</div>
              ) : history?.length === 0 ? (
                <div className="p-4 text-center text-gray-500">No reports generated yet</div>
              ) : (
                history?.slice(0, 5).map((report) => (
                  <div key={report.id} className="p-4 flex items-center justify-between">
                    <div className="flex items-center space-x-3">
                      {report.generationStatus === 'COMPLETED' ? (
                        <CheckCircle className="w-5 h-5 text-success-500" />
                      ) : (
                        <Clock className="w-5 h-5 text-warning-500" />
                      )}
                      <div>
                        <p className="text-sm font-medium text-gray-900">
                          {report.reportTemplate?.templateName}
                        </p>
                        <p className="text-xs text-gray-500">
                          {new Date(report.createdAt).toLocaleDateString()}
                        </p>
                      </div>
                    </div>
                    {report.generationStatus === 'COMPLETED' && (
                      <button
                        onClick={() => handleDownload(report.id)}
                        className="p-2 text-gray-400 hover:text-primary-600"
                      >
                        <Download className="w-4 h-4" />
                      </button>
                    )}
                  </div>
                ))
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

function TemplateCard({ name, description, selected, onClick }) {
  return (
    <button
      onClick={onClick}
      className={`p-4 rounded-lg border-2 text-left transition-colors ${
        selected
          ? 'border-primary-500 bg-primary-50'
          : 'border-gray-200 hover:border-gray-300'
      }`}
    >
      <div className="flex items-start space-x-3">
        <FileText className={`w-5 h-5 mt-0.5 ${selected ? 'text-primary-600' : 'text-gray-400'}`} />
        <div>
          <p className="font-medium text-gray-900">{name}</p>
          <p className="text-sm text-gray-500">{description}</p>
        </div>
      </div>
    </button>
  )
}
