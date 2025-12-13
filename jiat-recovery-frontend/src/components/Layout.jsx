import { Link, useLocation } from 'react-router-dom'
import { 
  LayoutDashboard, 
  FolderOpen, 
  Users, 
  Building2, 
  MessageSquare, 
  FileText,
  LogOut,
  Menu,
  X,
  RefreshCw
} from 'lucide-react'
import { useState } from 'react'
import { useAuthStore } from '../store/authStore'

const navigation = [
  { name: 'Dashboard', href: '/', icon: LayoutDashboard },
  { name: 'Recovery Cases', href: '/cases', icon: FolderOpen },
  { name: 'Students', href: '/students', icon: Users },
  { name: 'Bank Reconciliation', href: '/reconciliation', icon: Building2 },
  { name: 'Grievances', href: '/grievances', icon: MessageSquare },
  { name: 'Reports', href: '/reports', icon: FileText },
  { name: 'Data Sync', href: '/admin/sync', icon: RefreshCw },
]

export default function Layout({ children }) {
  const [sidebarOpen, setSidebarOpen] = useState(false)
  const location = useLocation()
  const { user, logout } = useAuthStore()

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Mobile sidebar backdrop */}
      {sidebarOpen && (
        <div 
          className="fixed inset-0 bg-gray-900/50 z-40 lg:hidden"
          onClick={() => setSidebarOpen(false)}
        />
      )}

      {/* Sidebar */}
      <aside className={`
        fixed top-0 left-0 z-50 h-full w-64 bg-white border-r border-gray-200 
        transform transition-transform duration-200 ease-in-out
        lg:translate-x-0 ${sidebarOpen ? 'translate-x-0' : '-translate-x-full'}
      `}>
        <div className="flex items-center justify-between h-16 px-6 border-b border-gray-200">
          <Link to="/" className="flex items-center space-x-2">
            <div className="w-8 h-8 bg-primary-600 rounded-lg flex items-center justify-center">
              <span className="text-white font-bold text-sm">JR</span>
            </div>
            <span className="font-semibold text-gray-900">JIAT Recovery</span>
          </Link>
          <button 
            className="lg:hidden p-1 text-gray-500 hover:text-gray-700"
            onClick={() => setSidebarOpen(false)}
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <nav className="p-4 space-y-1">
          {navigation.map((item) => {
            const isActive = location.pathname === item.href || 
              (item.href !== '/' && location.pathname.startsWith(item.href))
            return (
              <Link
                key={item.name}
                to={item.href}
                className={`
                  flex items-center space-x-3 px-3 py-2 rounded-lg text-sm font-medium
                  transition-colors duration-150
                  ${isActive 
                    ? 'bg-primary-50 text-primary-700' 
                    : 'text-gray-700 hover:bg-gray-100'
                  }
                `}
              >
                <item.icon className="w-5 h-5" />
                <span>{item.name}</span>
              </Link>
            )
          })}
        </nav>

        <div className="absolute bottom-0 left-0 right-0 p-4 border-t border-gray-200">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              <div className="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center">
                <span className="text-sm font-medium text-gray-600">
                  {user?.fullName?.charAt(0) || 'U'}
                </span>
              </div>
              <div className="text-sm">
                <p className="font-medium text-gray-900">{user?.fullName || 'User'}</p>
                <p className="text-gray-500 text-xs">{user?.role || 'Staff'}</p>
              </div>
            </div>
            <button 
              onClick={logout}
              className="p-2 text-gray-400 hover:text-gray-600 rounded-lg hover:bg-gray-100"
              title="Logout"
            >
              <LogOut className="w-4 h-4" />
            </button>
          </div>
        </div>
      </aside>

      {/* Main content */}
      <div className="lg:pl-64">
        {/* Top bar */}
        <header className="sticky top-0 z-30 bg-white border-b border-gray-200">
          <div className="flex items-center justify-between h-16 px-4 lg:px-8">
            <button 
              className="lg:hidden p-2 text-gray-500 hover:text-gray-700 rounded-lg hover:bg-gray-100"
              onClick={() => setSidebarOpen(true)}
            >
              <Menu className="w-5 h-5" />
            </button>
            <div className="flex-1 lg:flex-none" />
            <div className="text-sm text-gray-500">
              Java Institute for Advanced Technology
            </div>
          </div>
        </header>

        {/* Page content */}
        <main className="p-4 lg:p-8">
          {children}
        </main>
      </div>
    </div>
  )
}
