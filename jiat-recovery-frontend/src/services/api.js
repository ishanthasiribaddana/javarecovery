import axios from 'axios'
import { useAuthStore } from '../store/authStore'

const api = axios.create({
  baseURL: '/api',
  headers: {
    'Content-Type': 'application/json',
  },
})

// Request interceptor to add auth token
api.interceptors.request.use(
  (config) => {
    const token = useAuthStore.getState().token
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

// Response interceptor to handle errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      useAuthStore.getState().logout()
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

// Student API
export const studentApi = {
  getById: (id) => api.get(`/students/${id}`),
  getByStudentId: (studentId) => api.get(`/students/by-student-id/${studentId}`),
  search: (name, limit = 20) => api.get(`/students/search?name=${name}&limit=${limit}`),
  searchAll: (query, page = 0, size = 20) => api.get(`/students/search-all?q=${encodeURIComponent(query)}&page=${page}&size=${size}`),
  list: (query = '', page = 0, size = 20) => api.get(`/students/list?q=${encodeURIComponent(query)}&page=${page}&size=${size}`),
  getProfile: (query) => api.get(`/students/profile?q=${encodeURIComponent(query)}`),
  getProfileById: (sId) => api.get(`/students/profile/${sId}`),
  getPaymentManager: (id) => api.get(`/students/${id}/payment-manager`),
}

// Recovery Case API
export const caseApi = {
  create: (data) => api.post('/cases', data),
  getById: (id) => api.get(`/cases/${id}`),
  getByCaseNumber: (caseNumber) => api.get(`/cases/by-number/${caseNumber}`),
  getByStudentId: (studentSId) => api.get(`/cases/by-student/${studentSId}`),
  getOpenCases: () => api.get('/cases/open'),
  getByStatus: (status) => api.get(`/cases/by-status/${status}`),
  getByOfficer: (officerId) => api.get(`/cases/by-officer/${officerId}`),
  updateStatus: (id, data) => api.put(`/cases/${id}/status`, data),
  assign: (id, data) => api.put(`/cases/${id}/assign`, data),
  addNotes: (id, data) => api.post(`/cases/${id}/notes`, data),
  calculate: (id, data) => api.post(`/cases/${id}/calculate`, data),
  getCalculations: (id) => api.get(`/cases/${id}/calculations`),
  getLatestCalculation: (id) => api.get(`/cases/${id}/calculations/latest`),
}

// Grievance API
export const grievanceApi = {
  create: (data) => api.post('/grievances', data),
  getById: (id) => api.get(`/grievances/${id}`),
  getByStudentId: (studentSId) => api.get(`/grievances/by-student/${studentSId}`),
  getPending: () => api.get('/grievances/pending'),
  updateStatus: (id, data) => api.put(`/grievances/${id}/status`, data),
  resolve: (id, data) => api.put(`/grievances/${id}/resolve`, data),
}

// Bank Reconciliation API
export const reconciliationApi = {
  importFile: (formData) => api.post('/reconciliation/import', formData, {
    headers: { 'Content-Type': 'multipart/form-data' },
  }),
  getUnmatched: () => api.get('/reconciliation/unmatched'),
  matchDeposit: (id, data) => api.post(`/reconciliation/${id}/match`, data),
  verifyMatch: (id) => api.put(`/reconciliation/${id}/verify`),
}

// Report API
export const reportApi = {
  getTemplates: () => api.get('/reports/templates'),
  generate: (templateId, data) => api.post(`/reports/generate/${templateId}`, data),
  getHistory: () => api.get('/reports/history'),
  download: (reportId) => api.get(`/reports/download/${reportId}`, { responseType: 'blob' }),
}

// Auth API
export const authApi = {
  login: (credentials) => api.post('/auth/login', credentials),
  logout: () => api.post('/auth/logout'),
  me: () => api.get('/auth/me'),
}

// Outstanding Report API
export const outstandingApi = {
  getReport: (page = 0, size = 50, search = '') => 
    api.get(`/outstanding?page=${page}&size=${size}&search=${encodeURIComponent(search)}`),
  getSummary: () => api.get('/outstanding/summary'),
}

// Scholarship Diagnostic API
export const scholarshipDiagnosticApi = {
  getReport: () => api.get('/students/reports/scholarship-diagnostic'),
}

// Dashboard API
export const dashboardApi = {
  getAll: (officerId) => api.get(`/dashboard${officerId ? `?officerId=${officerId}` : ''}`),
  getStats: () => api.get('/dashboard/stats'),
  getMonthlyTrend: () => api.get('/dashboard/trend'),
  getOutstandingByCourse: () => api.get('/dashboard/outstanding-by-course'),
  getMyCases: (officerId) => api.get(`/dashboard/my-cases?officerId=${officerId}`),
  getActivity: (limit = 10) => api.get(`/dashboard/activity?limit=${limit}`),
}

export default api
