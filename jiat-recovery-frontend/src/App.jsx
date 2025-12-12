import { Routes, Route, Navigate } from 'react-router-dom'
import Layout from './components/Layout'
import Dashboard from './pages/Dashboard'
import CasesList from './pages/cases/CasesList'
import CaseDetail from './pages/cases/CaseDetail'
import StudentSearch from './pages/students/StudentSearch'
import StudentDetail from './pages/students/StudentDetail'
import BankReconciliation from './pages/reconciliation/BankReconciliation'
import GrievancesList from './pages/grievances/GrievancesList'
import Reports from './pages/reports/Reports'
import OutstandingReport from './pages/reports/OutstandingReport'
import OverdueStudentsReport from './pages/reports/OverdueStudentsReport'
import PaymentReconciliationReport from './pages/reports/PaymentReconciliationReport'
import ScholarshipDiagnosticReport from './pages/reports/ScholarshipDiagnosticReport'
import StudentRecoveryReport from './pages/reports/StudentRecoveryReport'
import Login from './pages/auth/Login'
import { useAuthStore } from './store/authStore'

function App() {
  const { isAuthenticated } = useAuthStore()

  if (!isAuthenticated) {
    return (
      <Routes>
        <Route path="/login" element={<Login />} />
        <Route path="*" element={<Navigate to="/login" replace />} />
      </Routes>
    )
  }

  return (
    <Layout>
      <Routes>
        <Route path="/" element={<Dashboard />} />
        <Route path="/cases" element={<CasesList />} />
        <Route path="/cases/:id" element={<CaseDetail />} />
        <Route path="/students" element={<StudentSearch />} />
        <Route path="/students/:id" element={<StudentDetail />} />
        <Route path="/reconciliation" element={<BankReconciliation />} />
        <Route path="/grievances" element={<GrievancesList />} />
        <Route path="/reports" element={<Reports />} />
        <Route path="/reports/outstanding" element={<OutstandingReport />} />
        <Route path="/reports/overdue-students" element={<OverdueStudentsReport />} />
        <Route path="/reports/reconciliation" element={<PaymentReconciliationReport />} />
        <Route path="/reports/scholarship-diagnostic" element={<ScholarshipDiagnosticReport />} />
        <Route path="/reports/student-recovery" element={<StudentRecoveryReport />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </Layout>
  )
}

export default App
