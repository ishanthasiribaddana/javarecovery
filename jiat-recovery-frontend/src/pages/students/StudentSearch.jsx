import { useState, useEffect } from 'react'
import { useQuery } from '@tanstack/react-query'
import { useSearchParams } from 'react-router-dom'
import { 
  Search, 
  User, 
  X, 
  CreditCard, 
  Gift, 
  History, 
  Phone, 
  Mail, 
  MapPin, 
  Calendar,
  GraduationCap,
  Percent,
  DollarSign,
  CheckCircle,
  Clock,
  AlertCircle,
  Building,
  Briefcase,
  Globe,
  MessageCircle,
  Home,
  PhoneCall,
  Laptop,
  Award,
  BookOpen,
  ChevronRight,
  ChevronDown
} from 'lucide-react'
import { studentApi } from '../../services/api'

export default function StudentSearch() {
  const [searchParams, setSearchParams] = useSearchParams()
  const [searchTerm, setSearchTerm] = useState('')
  const [searchQuery, setSearchQuery] = useState('')
  const [showAcademicInfo, setShowAcademicInfo] = useState(false)
  const [showOtherInfo, setShowOtherInfo] = useState(false)
  const [showPaymentStructure, setShowPaymentStructure] = useState(false)
  const [showScholarship, setShowScholarship] = useState(false)

  // Auto-search if NIC is provided in URL query params
  useEffect(() => {
    const nicFromUrl = searchParams.get('nic')
    if (nicFromUrl) {
      setSearchTerm(nicFromUrl)
      setSearchQuery(nicFromUrl)
      // Clear the URL param after using it
      setSearchParams({})
    }
  }, [searchParams, setSearchParams])

  // Search for student profile when query is provided
  const { data: studentProfile, isLoading, error } = useQuery({
    queryKey: ['student-profile', searchQuery],
    queryFn: () => studentApi.getProfile(searchQuery).then(res => res.data),
    enabled: searchQuery.length >= 2,
    retry: false,
  })

  const handleSearch = (e) => {
    e.preventDefault()
    if (searchTerm.length >= 2) {
      setSearchQuery(searchTerm)
    }
  }

  const clearSearch = () => {
    setSearchTerm('')
    setSearchQuery('')
  }

  // Use real data from API or show dummy for preview
  const student = studentProfile || null
  const showPreview = !searchQuery && !isLoading

  const dummyPaymentStructure = {
    totalCourseFee: 450000.00,
    registrationFee: 25000.00,
    monthlyInstallment: 15000.00,
    totalInstallments: 24,
    completedInstallments: 8,
    remainingInstallments: 16,
    nextDueDate: '2025-01-15',
    nextDueAmount: 15000.00
  }

  const dummyScholarship = {
    hasScholarship: true,
    scholarshipType: 'Merit-Based Scholarship',
    scholarshipPercentage: 25,
    scholarshipAmount: 112500.00,
    otherOffers: [
      { name: 'Early Bird Discount', amount: 10000.00, status: 'Applied' },
      { name: 'Sibling Discount', amount: 5000.00, status: 'Applied' },
      { name: 'Referral Bonus', amount: 2500.00, status: 'Pending' }
    ],
    totalDiscounts: 130000.00
  }

  // Student's selected payment plan and their installments
  const dummyPaymentPlan = {
    selectedPlan: 'Yearly', // Options: 'Full', 'Yearly', 'Semester'
    planDetails: {
      totalAmount: 450000.00,
      discountPercentage: 10, // Full gets highest discount, Semester gets lowest
      discountAmount: 45000.00,
      netAmount: 405000.00,
      numberOfInstallments: 8,
      paidInstallments: 5,
      paidAmount: 253125.00,
      dueAmount: 151875.00
    },
    // Installments within the selected plan
    installments: [
      { id: 1, date: '2024-01-15', description: 'Year 1 - Installment 1', amount: 50625.00, status: 'Paid', method: 'Bank Transfer', receiptNo: 'RCP-2024-001' },
      { id: 2, date: '2024-03-15', description: 'Year 1 - Installment 2', amount: 50625.00, status: 'Paid', method: 'Card Payment', receiptNo: 'RCP-2024-045' },
      { id: 3, date: '2024-05-15', description: 'Year 1 - Installment 3', amount: 50625.00, status: 'Paid', method: 'Bank Transfer', receiptNo: 'RCP-2024-089' },
      { id: 4, date: '2024-07-15', description: 'Year 1 - Installment 4', amount: 50625.00, status: 'Paid', method: 'Cash', receiptNo: 'RCP-2024-123' },
      { id: 5, date: '2024-09-15', description: 'Year 2 - Installment 1', amount: 50625.00, status: 'Paid', method: 'Bank Transfer', receiptNo: 'RCP-2024-167' },
      { id: 6, date: '2024-11-15', description: 'Year 2 - Installment 2', amount: 50625.00, status: 'Late', method: '-', receiptNo: '-' },
      { id: 7, date: '2025-01-15', description: 'Year 2 - Installment 3', amount: 50625.00, status: 'Pending', method: '-', receiptNo: '-' },
      { id: 8, date: '2025-03-15', description: 'Year 2 - Installment 4', amount: 50625.00, status: 'Pending', method: '-', receiptNo: '-' }
    ]
  }

  // Other payment categories (separate from main course fee plan)
  const dummyOtherPayments = {
    internationalDiploma: {
      title: 'International Payment - Diploma',
      payments: [
        { id: 101, date: '2024-03-01', description: 'SQA Diploma Registration', amount: 85000.00, status: 'Paid', method: 'Bank Transfer' }
      ],
      total: 85000.00,
      paid: 85000.00
    },
    internationalHigherDiploma: {
      title: 'International Payment - Higher Diploma',
      payments: [
        { id: 102, date: '2024-09-01', description: 'SQA Higher Diploma Registration', amount: 120000.00, status: 'Pending', method: '-' }
      ],
      total: 120000.00,
      paid: 0
    },
    universityPayment: {
      title: 'University Payment',
      payments: [
        { id: 103, date: '2024-06-01', description: 'University Registration', amount: 50000.00, status: 'Paid', method: 'Bank Transfer' },
        { id: 104, date: '2024-06-15', description: 'University Tuition', amount: 200000.00, status: 'Pending', method: '-' }
      ],
      total: 250000.00,
      paid: 50000.00
    },
    portalPayments: {
      title: 'Portal Payments',
      payments: [
        { id: 105, date: '2024-02-01', description: 'Portal Access - Year 1', amount: 15000.00, status: 'Paid', method: 'Card' },
        { id: 106, date: '2025-02-01', description: 'Portal Access - Year 2', amount: 15000.00, status: 'Pending', method: '-' },
        { id: 107, date: '2026-02-01', description: 'Portal Access - Year 3', amount: 15000.00, status: 'Pending', method: '-' }
      ],
      total: 45000.00,
      paid: 15000.00
    }
  }

  const [activeOtherPaymentTab, setActiveOtherPaymentTab] = useState('internationalDiploma')
  const [showAllPayments, setShowAllPayments] = useState(false)
  const [showAllOverdue, setShowAllOverdue] = useState(false)
  const [gbpToLkrRate, setGbpToLkrRate] = useState(null)

  // Fetch GBP to LKR exchange rate from free API
  useEffect(() => {
    const fetchExchangeRate = async () => {
      try {
        // Using exchangerate-api.com free tier (no API key required for basic usage)
        const response = await fetch('https://api.exchangerate-api.com/v4/latest/GBP');
        const data = await response.json();
        if (data && data.rates && data.rates.LKR) {
          setGbpToLkrRate(data.rates.LKR);
        }
      } catch (error) {
        console.error('Failed to fetch exchange rate:', error);
        // Fallback rate if API fails
        setGbpToLkrRate(380); // Approximate fallback
      }
    };
    fetchExchangeRate();
  }, []);

  const formatCurrency = (amount) => {
    return new Intl.NumberFormat('en-LK', { style: 'currency', currency: 'LKR' }).format(amount)
  }

  const getStatusBadge = (status) => {
    switch (status) {
      case 'Paid':
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"><CheckCircle className="w-3 h-3 mr-1" />Paid</span>
      case 'Late':
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800"><Clock className="w-3 h-3 mr-1" />Late</span>
      case 'Pending':
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800"><Clock className="w-3 h-3 mr-1" />Pending</span>
      case 'Applied':
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800"><CheckCircle className="w-3 h-3 mr-1" />Applied</span>
      default:
        return <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">{status}</span>
    }
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl font-bold text-gray-900">Student Search</h1>
        <p className="text-gray-500 mt-1">Search by NIC or Name to view student details</p>
      </div>

      {/* Search Form */}
      <div className="card bg-gradient-to-r from-blue-600 to-blue-700 text-white">
        <div className="card-body">
          <form onSubmit={handleSearch} className="flex gap-4">
            <div className="flex-1 relative">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
              <input
                type="text"
                placeholder="Enter NIC number or student name..."
                className="w-full pl-12 pr-12 py-3 rounded-lg text-gray-900 bg-white border-0 focus:ring-2 focus:ring-blue-300 text-lg"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
              {searchTerm && (
                <button
                  type="button"
                  onClick={clearSearch}
                  className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                >
                  <X className="w-5 h-5" />
                </button>
              )}
            </div>
            <button type="submit" className="px-8 py-3 bg-white text-blue-600 font-semibold rounded-lg hover:bg-blue-50 transition-colors">
              Search
            </button>
          </form>
          <p className="text-blue-100 text-sm mt-2">Enter at least 2 characters to search</p>
        </div>
      </div>

      {/* Loading State */}
      {isLoading && (
        <div className="card">
          <div className="card-body text-center py-12">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
            <p className="text-gray-500 mt-4">Searching for student...</p>
          </div>
        </div>
      )}

      {/* No Results */}
      {searchQuery && !isLoading && !student && (
        <div className="card">
          <div className="card-body text-center py-12">
            <AlertCircle className="w-12 h-12 text-gray-300 mx-auto mb-4" />
            <h3 className="text-lg font-medium text-gray-900 mb-2">No Student Found</h3>
            <p className="text-gray-500">No student found matching "{searchQuery}". Please try a different search.</p>
          </div>
        </div>
      )}

      {/* Student Details - Show when student is found or with dummy data for design preview */}
      {(student || showPreview) && (
        <div className="space-y-6">
          {/* Student Found Banner */}
          {student && searchQuery && (
            <div className="bg-green-50 border border-green-200 rounded-lg p-4 flex items-center justify-between">
              <div className="flex items-center">
                <div className="w-10 h-10 bg-gradient-to-br from-blue-400 to-blue-600 rounded-full flex items-center justify-center text-white text-sm font-bold mr-3">
                  {(student?.fullName || student?.firstName || 'JD').split(' ').map(n => n?.[0] || '').join('').substring(0, 2).toUpperCase()}
                </div>
                <span className="text-green-800">Student found: <strong>{student.fullName || `${student.firstName} ${student.lastName}`}</strong> ({student.nic})</span>
              </div>
              <div className="flex items-center gap-4 text-sm">
                {student?.email && (
                  <div className="flex items-center">
                    <Mail className="w-4 h-4 text-green-600 mr-1" />
                    <span className="text-green-800">{student.email}</span>
                  </div>
                )}
                {student?.mobilePhone && (
                  <div className="flex items-center">
                    <Phone className="w-4 h-4 text-green-600 mr-1" />
                    <span className="text-green-800">{student.mobilePhone}</span>
                  </div>
                )}
                {student?.whatsapp && student.whatsapp !== 'N/A' && (
                  <div className="flex items-center">
                    <MessageCircle className="w-4 h-4 text-green-600 mr-1" />
                    <span className="text-green-800">{student.whatsapp}</span>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Due Summary Cards */}
          {student && studentProfile && (
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {(() => {
                // Calculate Course Fee Due
                const totalCourseFee = studentProfile?.totalCourseFee || 3000000;
                const scholarshipPct = studentProfile?.scholarshipPercentage || 0;
                const payableCourseFee = studentProfile?.payableCourseFee || (totalCourseFee * (1 - scholarshipPct / 100));
                const coursePayments = studentProfile?.paymentSchedule?.paymentHistory?.filter(p => !p.international && p.courseId !== 410) || [];
                const coursePaid = coursePayments.reduce((sum, p) => sum + (p.paidAmount || 0), 0);
                const courseFeeDue = Math.max(0, payableCourseFee - coursePaid);
                
                // Calculate International/University Fee Due
                const intlPayments = studentProfile?.paymentSchedule?.paymentHistory?.filter(p => p.international) || [];
                const gbpPayments = intlPayments.filter(p => p.courseId !== 410);
                const course410Payments = intlPayments.filter(p => p.courseId === 410);
                const gbpPaid = gbpPayments.reduce((sum, p) => sum + (p.paidAmount || 0), 0);
                const course410Paid = course410Payments.reduce((sum, p) => sum + (p.paidAmount || 0), 0);
                
                // UK Awards total: £340 (Level 1=£100, Level 2=£110, Level 3=£130)
                // Course 410: LKR 530,000
                const ukAwardsFee = 340;
                const course410Fee = 530000;
                const gbpDue = gbpPayments.length > 0 ? Math.max(0, ukAwardsFee - gbpPaid) : 0;
                const course410Due = course410Payments.length > 0 ? Math.max(0, course410Fee - course410Paid) : 0;
                
                // Calculate Other Payments Due (Portal Fee, ID Card, Convocation, etc.)
                const otherPayments = studentProfile?.paymentSchedule?.paymentHistory?.filter(p => {
                  const desc = (p.description || '').toLowerCase();
                  return !p.international && (
                    desc.includes('portal') || 
                    desc.includes('id card') || 
                    desc.includes('convocation') ||
                    desc.includes('registration') ||
                    desc.includes('exam') ||
                    desc.includes('library')
                  );
                }) || [];
                // For other payments, we just show what's been paid (no standard due amount)
                const otherPaid = otherPayments.reduce((sum, p) => sum + (p.paidAmount || 0), 0);
                
                // Check if student has any pending installments
                const pendingInstallments = studentProfile?.paymentSchedule?.overdueInstallments || [];
                const upcomingInstallments = studentProfile?.paymentSchedule?.upcomingInstallments || [];
                const totalInstallmentDue = [...pendingInstallments, ...upcomingInstallments]
                  .reduce((sum, inst) => sum + (inst.dueAmount || 0), 0);
                
                return (
                  <>
                    {/* Course Fee Due Card */}
                    <div className={`rounded-xl p-4 border-2 ${courseFeeDue > 0 ? 'bg-red-50 border-red-300' : 'bg-green-50 border-green-300'}`}>
                      <div className="flex items-center justify-between mb-2">
                        <span className="text-xs font-semibold uppercase text-gray-600">Course Fee Due</span>
                        <span className={`w-3 h-3 rounded-full ${courseFeeDue > 0 ? 'bg-red-500 animate-pulse' : 'bg-green-500'}`}></span>
                      </div>
                      <p className={`text-2xl font-bold ${courseFeeDue > 0 ? 'text-red-700' : 'text-green-700'}`}>
                        {formatCurrency(courseFeeDue)}
                      </p>
                      <p className="text-xs text-gray-500 mt-1">
                        Paid: {formatCurrency(coursePaid)} / {formatCurrency(payableCourseFee)}
                      </p>
                      {totalInstallmentDue > 0 && (
                        <p className="text-xs text-orange-600 mt-1 font-medium">
                          📅 Installment Due: {formatCurrency(totalInstallmentDue)}
                        </p>
                      )}
                    </div>
                    
                    {/* International/University Fee Due Card */}
                    <div className={`rounded-xl p-4 border-2 ${(gbpDue > 0 || course410Due > 0) ? 'bg-purple-50 border-purple-300' : 'bg-green-50 border-green-300'}`}>
                      <div className="flex items-center justify-between mb-2">
                        <span className="text-xs font-semibold uppercase text-gray-600">International Fee Due</span>
                        <span className={`w-3 h-3 rounded-full ${(gbpDue > 0 || course410Due > 0) ? 'bg-purple-500 animate-pulse' : 'bg-green-500'}`}></span>
                      </div>
                      <p className={`text-2xl font-bold ${(gbpDue > 0 || course410Due > 0) ? 'text-purple-700' : 'text-green-700'}`}>
                        {gbpDue > 0 ? `£${gbpDue.toLocaleString()}` : '£0'}
                        {course410Due > 0 && <span className="text-lg ml-1">+ {formatCurrency(course410Due)}</span>}
                      </p>
                      <p className="text-xs text-gray-500 mt-1">
                        {gbpPayments.length > 0 ? `UK Awards: £${gbpPaid} paid` : 'No UK Awards payments'}
                        {course410Payments.length > 0 && ` | Univ: ${formatCurrency(course410Paid)} paid`}
                      </p>
                      {intlPayments.length === 0 && (
                        <p className="text-xs text-blue-600 mt-1 font-medium">
                          ℹ️ No international payments yet
                        </p>
                      )}
                    </div>
                    
                    {/* Other Payments Card */}
                    <div className="rounded-xl p-4 border-2 bg-blue-50 border-blue-300">
                      <div className="flex items-center justify-between mb-2">
                        <span className="text-xs font-semibold uppercase text-gray-600">Other Payments</span>
                        <span className="w-3 h-3 rounded-full bg-blue-500"></span>
                      </div>
                      <p className="text-2xl font-bold text-blue-700">
                        {formatCurrency(otherPaid)}
                      </p>
                      <p className="text-xs text-gray-500 mt-1">
                        {otherPayments.length} payment(s) recorded
                      </p>
                      <p className="text-xs text-gray-400 mt-1">
                        Portal, ID Card, Convocation, etc.
                      </p>
                    </div>
                  </>
                );
              })()}
            </div>
          )}

          {/* Design Preview Notice */}
          {showPreview && (
            <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 flex items-center">
              <AlertCircle className="w-5 h-5 text-blue-600 mr-3" />
              <span className="text-blue-800">Design Preview: Showing dummy data. Search for a student to see real data.</span>
            </div>
          )}

          {/* 4 Segments Grid */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            
            {/* Segment 1: Academic Information - Collapsible */}
            <div className="card border-t-4 border-t-blue-500 self-start">
              <div 
                className="card-header bg-blue-50 cursor-pointer hover:bg-blue-100 transition-colors"
                onClick={() => setShowAcademicInfo(!showAcademicInfo)}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center">
                    <div className="w-10 h-10 bg-blue-500 rounded-lg flex items-center justify-center mr-3">
                      <User className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <h2 className="text-lg font-semibold text-gray-900">Academic Information</h2>
                      <p className="text-sm text-gray-500">Student information for recovery</p>
                    </div>
                  </div>
                  {showAcademicInfo ? (
                    <ChevronDown className="w-5 h-5 text-gray-500" />
                  ) : (
                    <ChevronRight className="w-5 h-5 text-gray-500" />
                  )}
                </div>
              </div>
              {showAcademicInfo && (
                <div className="card-body">
                  <div className="mb-4">
                    <div className="space-y-2">
                      <div className="flex items-center text-sm">
                        <GraduationCap className="w-4 h-4 text-indigo-500 mr-3" />
                        <span className="text-gray-500 w-28">Course:</span>
                        <span className="font-medium text-gray-900">{student?.courseTitle || 'Software Engineering'}</span>
                      </div>
                      <div className="flex items-center text-sm">
                        <Building className="w-4 h-4 text-gray-500 mr-3" />
                        <span className="text-gray-500 w-28">Branch:</span>
                        <span className="font-medium text-gray-900">{student?.branchName || 'N/A'}</span>
                      </div>
                      <div className="flex items-center text-sm">
                        <Calendar className="w-4 h-4 text-teal-500 mr-3" />
                        <span className="text-gray-500 w-28">Intake:</span>
                        <span className="font-medium text-gray-900">{student?.intakeName || 'N/A'}</span>
                      </div>
                      <div className="flex items-center text-sm">
                        <Calendar className="w-4 h-4 text-gray-500 mr-3" />
                        <span className="text-gray-500 w-28">Academic Year:</span>
                        <span className="font-medium text-gray-900">{student?.academicYear || 'N/A'}</span>
                      </div>
                      <div className="flex items-center text-sm">
                        <Calendar className="w-4 h-4 text-green-500 mr-3" />
                        <span className="text-gray-500 w-28">Registered:</span>
                        <span className="font-medium text-gray-900">
                          {studentProfile?.firstPaymentDate 
                            ? new Date(studentProfile.firstPaymentDate).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
                            : 'N/A'}
                        </span>
                      </div>
                    </div>
                  </div>
                  {student?.courseFeeTotalDueAmount > 0 && (
                    <div className="mt-4 bg-red-50 border border-red-200 rounded-lg p-3">
                      <div className="flex items-center justify-between">
                        <span className="text-red-700 font-medium">Outstanding Due:</span>
                        <span className="text-xl font-bold text-red-600">{formatCurrency(student.courseFeeTotalDueAmount)}</span>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </div>

            {/* Other Information - Collapsible */}
            <div className="card border-t-4 border-t-indigo-500 self-start">
              <div 
                className="card-header bg-indigo-50 cursor-pointer hover:bg-indigo-100 transition-colors"
                onClick={() => setShowOtherInfo(!showOtherInfo)}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center">
                    <div className="w-10 h-10 bg-indigo-500 rounded-lg flex items-center justify-center mr-3">
                      <User className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <h2 className="text-lg font-semibold text-gray-900">Other Information</h2>
                      <p className="text-sm text-gray-500">Guardian & additional details</p>
                    </div>
                  </div>
                  {showOtherInfo ? (
                    <ChevronDown className="w-5 h-5 text-gray-500" />
                  ) : (
                    <ChevronRight className="w-5 h-5 text-gray-500" />
                  )}
                </div>
              </div>
              {showOtherInfo && (
                <div className="card-body">
                  <div className="mb-4">
                    <h4 className="text-sm font-semibold text-gray-700 mb-2 border-b pb-1">Guardian Information</h4>
                    <div className="space-y-2">
                      <div className="flex items-center text-sm">
                        <User className="w-4 h-4 text-indigo-500 mr-3" />
                        <span className="text-gray-500 w-28">Guardian:</span>
                        <span className="font-medium text-gray-900">
                          {student?.guardianName || 'N/A'}
                          {student?.guardianRelationship && (
                            <span className="ml-2 text-xs text-gray-500">({student.guardianRelationship})</span>
                          )}
                        </span>
                      </div>
                      <div className="flex items-center text-sm">
                        <Phone className="w-4 h-4 text-green-500 mr-3" />
                        <span className="text-gray-500 w-28">Contact:</span>
                        <span className="font-medium text-gray-900">{student?.guardianContact || 'N/A'}</span>
                      </div>
                    </div>
                  </div>
                </div>
              )}
            </div>

            {/* Segment 2: Payment Structure - Collapsible */}
            <div className="card border-t-4 border-t-green-500 self-start">
              <div 
                className="card-header bg-green-50 cursor-pointer hover:bg-green-100 transition-colors"
                onClick={() => setShowPaymentStructure(!showPaymentStructure)}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center">
                    <div className="w-10 h-10 bg-green-500 rounded-lg flex items-center justify-center mr-3">
                      <CreditCard className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <h2 className="text-lg font-semibold text-gray-900">Payment Structure</h2>
                      <p className="text-sm text-gray-500">Fee breakdown & schedule</p>
                    </div>
                  </div>
                  {showPaymentStructure ? (
                    <ChevronDown className="w-5 h-5 text-gray-500" />
                  ) : (
                    <ChevronRight className="w-5 h-5 text-gray-500" />
                  )}
                </div>
              </div>
              {showPaymentStructure && (
                <div className="card-body">
                  <div className="grid grid-cols-2 gap-4 mb-6">
                    <div className="bg-green-50 rounded-lg p-4 text-center">
                      <p className="text-sm text-gray-500">Total Course Fee</p>
                      <p className="text-2xl font-bold text-green-600">{formatCurrency(dummyPaymentStructure.totalCourseFee)}</p>
                    </div>
                    <div className="bg-blue-50 rounded-lg p-4 text-center">
                      <p className="text-sm text-gray-500">Registration Fee</p>
                      <p className="text-2xl font-bold text-blue-600">{formatCurrency(dummyPaymentStructure.registrationFee)}</p>
                    </div>
                  </div>
                  <div className="space-y-3">
                    <div className="flex justify-between items-center py-2 border-b">
                      <span className="text-gray-500">Monthly Installment</span>
                      <span className="font-semibold text-gray-900">{formatCurrency(dummyPaymentStructure.monthlyInstallment)}</span>
                    </div>
                    <div className="flex justify-between items-center py-2 border-b">
                      <span className="text-gray-500">Total Installments</span>
                      <span className="font-semibold text-gray-900">{dummyPaymentStructure.totalInstallments}</span>
                    </div>
                    <div className="flex justify-between items-center py-2 border-b">
                      <span className="text-gray-500">Completed</span>
                      <span className="font-semibold text-green-600">{dummyPaymentStructure.completedInstallments} / {dummyPaymentStructure.totalInstallments}</span>
                    </div>
                    <div className="flex justify-between items-center py-2 border-b">
                      <span className="text-gray-500">Remaining</span>
                      <span className="font-semibold text-orange-600">{dummyPaymentStructure.remainingInstallments}</span>
                    </div>
                  </div>
                  <div className="mt-4 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
                    <div className="flex items-center">
                      <Clock className="w-5 h-5 text-yellow-600 mr-2" />
                      <span className="text-yellow-800 font-medium">Next Payment Due</span>
                    </div>
                    <div className="mt-2 flex justify-between items-center">
                      <span className="text-gray-600">{dummyPaymentStructure.nextDueDate}</span>
                      <span className="text-xl font-bold text-yellow-700">{formatCurrency(dummyPaymentStructure.nextDueAmount)}</span>
                    </div>
                  </div>
                </div>
              )}
            </div>

            {/* Segment 3: Scholarship & Other Offers - Collapsible */}
            <div className="card border-t-4 border-t-purple-500 self-start">
              <div 
                className="card-header bg-purple-50 cursor-pointer hover:bg-purple-100 transition-colors"
                onClick={() => setShowScholarship(!showScholarship)}
              >
                <div className="flex items-center justify-between">
                  <div className="flex items-center">
                    <div className="w-10 h-10 bg-purple-500 rounded-lg flex items-center justify-center mr-3">
                      <Gift className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <h2 className="text-lg font-semibold text-gray-900">Scholarship & Offers</h2>
                      <p className="text-sm text-gray-500">Discounts & benefits</p>
                    </div>
                  </div>
                  {showScholarship ? (
                    <ChevronDown className="w-5 h-5 text-gray-500" />
                  ) : (
                    <ChevronRight className="w-5 h-5 text-gray-500" />
                  )}
                </div>
              </div>
              {showScholarship && (
                <div className="card-body">
                  {dummyScholarship.hasScholarship && (
                    <div className="bg-gradient-to-r from-purple-500 to-purple-600 rounded-lg p-4 text-white mb-6">
                      <div className="flex items-center justify-between">
                        <div>
                          <p className="text-purple-100 text-sm">Scholarship</p>
                          <p className="text-xl font-bold">{dummyScholarship.scholarshipType}</p>
                        </div>
                        <div className="text-right">
                          <div className="flex items-center justify-end">
                            <Percent className="w-5 h-5 mr-1" />
                            <span className="text-3xl font-bold">{dummyScholarship.scholarshipPercentage}%</span>
                          </div>
                          <p className="text-purple-100 text-sm">{formatCurrency(dummyScholarship.scholarshipAmount)}</p>
                        </div>
                      </div>
                    </div>
                  )}
                  <div className="space-y-3">
                    <h4 className="font-medium text-gray-700">Other Offers</h4>
                    {dummyScholarship.otherOffers.map((offer, index) => (
                      <div key={index} className="flex justify-between items-center py-2 px-3 bg-gray-50 rounded-lg">
                        <div>
                          <span className="font-medium text-gray-900">{offer.name}</span>
                          <span className="ml-2">{getStatusBadge(offer.status)}</span>
                        </div>
                        <span className="font-semibold text-green-600">-{formatCurrency(offer.amount)}</span>
                      </div>
                    ))}
                  </div>
                  <div className="mt-6 pt-4 border-t">
                    <div className="flex justify-between items-center">
                      <span className="text-lg font-medium text-gray-700">Total Discounts</span>
                      <span className="text-2xl font-bold text-purple-600">{formatCurrency(dummyScholarship.totalDiscounts)}</span>
                    </div>
                  </div>
                </div>
              )}
            </div>

            {/* Segment 4: Course Fee Payment Plan & Installments */}
            <div className="card border-t-4 border-t-orange-500 lg:col-span-2">
              <div className="card-header bg-orange-50">
                <div className="flex items-center justify-between">
                  <div className="flex items-center">
                    <div className="w-10 h-10 bg-orange-500 rounded-lg flex items-center justify-center mr-3">
                      <CreditCard className="w-5 h-5 text-white" />
                    </div>
                    <div>
                      <h2 className="text-lg font-semibold text-gray-900">Course Fee - Payment Plan</h2>
                      <p className="text-sm text-gray-500">Selected plan and installment history</p>
                    </div>
                  </div>
                  {/* Selected Plan Badge - From API (Default to Semester Plan if not assigned) */}
                  {studentProfile?.paymentOptionName ? (
                    <div className={`px-4 py-2 rounded-lg font-bold text-white ${
                      studentProfile.paymentOptionId === 1 ? 'bg-emerald-500' :
                      studentProfile.paymentOptionId === 2 ? 'bg-blue-500' :
                      studentProfile.paymentOptionId === 3 ? 'bg-indigo-500' :
                      studentProfile.paymentOptionId === 4 ? 'bg-purple-500' : 'bg-gray-500'
                    }`}>
                      {studentProfile.paymentOptionId === 1 && <CheckCircle className="w-4 h-4 inline mr-1" />}
                      {studentProfile.paymentOptionId === 2 && <Calendar className="w-4 h-4 inline mr-1" />}
                      {studentProfile.paymentOptionId === 3 && <BookOpen className="w-4 h-4 inline mr-1" />}
                      {studentProfile.paymentOptionId === 4 && <Clock className="w-4 h-4 inline mr-1" />}
                      {studentProfile.paymentOptionId === 5 && <CreditCard className="w-4 h-4 inline mr-1" />}
                      {studentProfile.paymentOptionName}
                    </div>
                  ) : (
                    <div className="px-4 py-2 rounded-lg font-bold text-white bg-amber-500 border-2 border-amber-600">
                      <BookOpen className="w-4 h-4 inline mr-1" /> Semester Plan (Default)
                      <span className="ml-2 text-xs bg-amber-600 px-1.5 py-0.5 rounded">⚠️ Verify</span>
                    </div>
                  )}
                </div>
              </div>
              <div className="card-body">
                {/* Scholarship & Course Fee Summary Cards */}
                {(() => {
                  // Check if student has no scholarship assigned - apply lowest available semester plan (35%)
                  const hasNoScholarship = !studentProfile?.scholarshipPercentage || studentProfile?.scholarshipPercentage === 0;
                  const lowestSemesterScholarshipPct = 35; // Lowest available semester plan scholarship percentage
                  const totalFee = studentProfile?.totalCourseFee || 3000000;
                  
                  // Calculate values based on lowest semester plan if no scholarship
                  const displayScholarshipPct = hasNoScholarship ? lowestSemesterScholarshipPct : studentProfile?.scholarshipPercentage;
                  const displayScholarshipAmount = hasNoScholarship ? (totalFee * lowestSemesterScholarshipPct / 100) : (studentProfile?.scholarshipAmount || 0);
                  const displayPayableFee = hasNoScholarship ? (totalFee - displayScholarshipAmount) : (studentProfile?.payableCourseFee || 0);
                  
                  return (
                    <>
                      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
                        <div className="bg-gray-50 rounded-lg p-4 text-center">
                          <p className="text-xs text-gray-500 uppercase">Total Course Fee</p>
                          <p className="text-xl font-bold text-gray-900">{formatCurrency(totalFee)}</p>
                        </div>
                        <div className={`rounded-lg p-4 text-center ${hasNoScholarship ? 'bg-amber-50 border border-amber-200' : 'bg-purple-50'}`}>
                          <p className="text-xs text-gray-500 uppercase">Scholarship Percentage</p>
                          <p className={`text-xl font-bold ${hasNoScholarship ? 'text-amber-600' : 'text-purple-600'}`}>
                            {displayScholarshipPct}%
                            {hasNoScholarship && <span className="text-xs ml-1">(Semester)</span>}
                          </p>
                        </div>
                        <div className={`rounded-lg p-4 text-center ${hasNoScholarship ? 'bg-amber-50 border border-amber-200' : 'bg-green-50'}`}>
                          <p className="text-xs text-gray-500 uppercase">Scholarship Value</p>
                          <p className={`text-xl font-bold ${hasNoScholarship ? 'text-amber-600' : 'text-green-600'}`}>
                            {formatCurrency(displayScholarshipAmount)}
                          </p>
                        </div>
                        <div className={`rounded-lg p-4 text-center ${hasNoScholarship ? 'bg-amber-50 border border-amber-200' : 'bg-blue-50'}`}>
                          <p className="text-xs text-gray-500 uppercase">Payable Course Fee</p>
                          <p className={`text-xl font-bold ${hasNoScholarship ? 'text-amber-600' : 'text-blue-600'}`}>
                            {formatCurrency(displayPayableFee)}
                          </p>
                          {hasNoScholarship && (
                            <p className="text-xs text-amber-700 mt-1 font-medium">⚠️ Must be verified</p>
                          )}
                        </div>
                      </div>
                      {hasNoScholarship && (
                        <div className="mb-4 bg-amber-50 border border-amber-300 rounded-lg p-3 flex items-start">
                          <span className="text-xl mr-3">⚠️</span>
                          <div>
                            <p className="text-amber-800 font-semibold text-sm">Scholarship Verification Required</p>
                            <p className="text-amber-700 text-xs">This student has no scholarship assigned. Lowest available semester plan ({lowestSemesterScholarshipPct}%) has been applied. <strong>Must be verified with the scholarship examination results.</strong></p>
                          </div>
                        </div>
                      )}
                    </>
                  );
                })()}

                {/* Offer/Discount Section - Always shown */}
                <div className="border-t border-dashed border-gray-300 pt-4 mb-6">
                  <div className="flex items-center mb-3">
                    <Gift className={`w-4 h-4 mr-2 ${studentProfile?.offerApplied ? 'text-amber-500' : 'text-gray-400'}`} />
                    <span className="text-sm font-semibold text-gray-700">Additional Offer</span>
                    {studentProfile?.offerApplied ? (
                      <span className="ml-2 px-2 py-0.5 bg-amber-100 text-amber-700 text-xs rounded-full">{studentProfile.offerName || 'Special Offer'}</span>
                    ) : (
                      <span className="ml-2 px-2 py-0.5 bg-gray-100 text-gray-500 text-xs rounded-full">No Offer Applied</span>
                    )}
                  </div>
                  
                  {/* Message for students without additional offer */}
                  {!studentProfile?.offerApplied && (
                    <div className="mb-4 bg-blue-50 border border-blue-200 rounded-lg p-3 flex items-start">
                      <span className="text-xl mr-3">💡</span>
                      <div>
                        <p className="text-blue-800 font-semibold text-sm">No Additional Offer Applied</p>
                        <p className="text-blue-700 text-xs">This student is currently paying the standard course fee based on their scholarship percentage. Contact the admissions team if eligible for any promotional offers or discounts.</p>
                      </div>
                    </div>
                  )}
                  
                  <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                    <div className={`rounded-lg p-4 text-center border ${studentProfile?.offerApplied ? 'bg-amber-50 border-amber-200' : 'bg-gray-50 border-gray-200'}`}>
                      <p className="text-xs text-gray-500 uppercase">Offer Discount</p>
                      <p className={`text-xl font-bold ${studentProfile?.offerApplied ? 'text-amber-600' : 'text-gray-400'}`}>
                        {studentProfile?.offerApplied 
                          ? (studentProfile.offerDiscountPercentage > 0 
                              ? `${studentProfile.offerDiscountPercentage}%` 
                              : formatCurrency(studentProfile.offerDiscountAmount || 0))
                          : '-'}
                      </p>
                      <p className="text-xs text-gray-400 mt-1">
                        {studentProfile?.offerApplied 
                          ? (studentProfile.offerDiscountPercentage > 0 ? 'Percentage discount' : 'Fixed amount')
                          : 'No discount'}
                      </p>
                    </div>
                    <div className={`rounded-lg p-4 text-center border ${studentProfile?.offerApplied ? 'bg-rose-50 border-rose-200' : 'bg-gray-50 border-gray-200'}`}>
                      <p className="text-xs text-gray-500 uppercase">Valid Until</p>
                      <p className={`text-xl font-bold ${studentProfile?.offerApplied ? 'text-rose-600' : 'text-gray-400'}`}>
                        {studentProfile?.offerApplied 
                          ? (studentProfile.offerValidUntil 
                              ? new Date(studentProfile.offerValidUntil).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
                              : 'No Expiry')
                          : '-'}
                      </p>
                      <p className="text-xs text-gray-400 mt-1">Offer expiry date</p>
                    </div>
                    <div className={`rounded-lg p-4 text-center border ${studentProfile?.offerApplied ? 'bg-teal-50 border-teal-200' : 'bg-gray-50 border-gray-200'}`}>
                      <p className="text-xs text-gray-500 uppercase">Offer Value</p>
                      <p className={`text-xl font-bold ${studentProfile?.offerApplied ? 'text-teal-600' : 'text-gray-400'}`}>
                        {studentProfile?.offerApplied ? formatCurrency(studentProfile.offerValue || 0) : '-'}
                      </p>
                      <p className="text-xs text-gray-400 mt-1">Discount amount</p>
                    </div>
                    <div className="bg-indigo-50 rounded-lg p-4 text-center border border-indigo-200">
                      <p className="text-xs text-gray-500 uppercase">Final Payable</p>
                      <p className="text-xl font-bold text-indigo-600">{formatCurrency(studentProfile?.finalPayable || studentProfile?.payableCourseFee || 0)}</p>
                      <p className="text-xs text-gray-400 mt-1">After all discounts</p>
                    </div>
                  </div>
                </div>

                {/* Payment Schedule Status Section */}
                {studentProfile?.paymentSchedule && (
                  <div className="border-t border-gray-200 pt-4 mb-6">
                    {/* Section Header */}
                    <div className="flex items-center justify-between mb-4">
                      <div className="flex items-center">
                        <Calendar className="w-5 h-5 text-gray-600 mr-2" />
                        <h4 className="font-semibold text-gray-800">Payment Schedule Status</h4>
                      </div>
                      <span className="px-3 py-1 bg-blue-100 text-blue-700 text-xs font-medium rounded-full">
                        {studentProfile.paymentSchedule.paymentOptionName || 'Payment Plan'}
                      </span>
                    </div>

                    {/* Overdue Payments Alert - Only show if there are overdue installments */}
                    {studentProfile.paymentSchedule.overdueInstallments?.length > 0 && (
                      <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-4">
                        <div className="flex items-center justify-between mb-3">
                          <div className="flex items-center">
                            <AlertCircle className="w-5 h-5 text-red-500 mr-2" />
                            <span className="font-semibold text-red-700">Overdue Payments</span>
                          </div>
                          <div className="text-right">
                            <span className="text-xs text-gray-500">Total Overdue: </span>
                            <span className="font-bold text-red-600">{formatCurrency(studentProfile.paymentSchedule.totalOverdueAmount || 0)}</span>
                          </div>
                        </div>
                        <div className="space-y-2">
                          {(showAllOverdue ? studentProfile.paymentSchedule.overdueInstallments : studentProfile.paymentSchedule.overdueInstallments.slice(0, 5)).map((inst, idx) => (
                            <div key={inst.id || idx} className="flex items-center justify-between bg-white rounded-lg px-3 py-2 border border-red-100">
                              <div className="flex items-center">
                                <div className="w-8 h-8 bg-red-100 rounded-full flex items-center justify-center mr-3">
                                  <span className="text-xs font-bold text-red-600">{idx + 1}</span>
                                </div>
                                <div>
                                  <p className="text-sm font-medium text-gray-800">{inst.description}</p>
                                  <p className="text-xs text-gray-500">Due: {inst.dateToBePaid ? new Date(inst.dateToBePaid).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }) : 'N/A'}</p>
                                </div>
                              </div>
                              <div className="text-right">
                                <p className="text-sm font-bold text-gray-800">{formatCurrency(inst.dueAmount || 0)}</p>
                                <p className="text-xs font-semibold text-red-600">Delayed {inst.daysOverdue} days</p>
                              </div>
                            </div>
                          ))}
                          {studentProfile.paymentSchedule.overdueInstallments.length > 5 && (
                            <div 
                              className="text-center py-2 cursor-pointer hover:bg-red-100 rounded-lg transition-colors"
                              onClick={() => setShowAllOverdue(!showAllOverdue)}
                            >
                              <span className="text-xs font-medium text-red-600">
                                {showAllOverdue ? 'Show less ▲' : `Show all ${studentProfile.paymentSchedule.overdueInstallments.length} overdue payments ▼`}
                              </span>
                            </div>
                          )}
                        </div>
                        <div className="mt-3 pt-3 border-t border-red-200 flex justify-between items-center">
                          <span className="text-sm text-red-700 font-medium">
                            Total Delay: {studentProfile.paymentSchedule.totalDelayDays} days across {studentProfile.paymentSchedule.overdueCount} installment{studentProfile.paymentSchedule.overdueCount > 1 ? 's' : ''}
                          </span>
                        </div>
                      </div>
                    )}

                    {/* Upcoming Payments - Only show if there are upcoming installments */}
                    {studentProfile.paymentSchedule.upcomingInstallments?.length > 0 && (
                      <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                        <div className="flex items-center mb-3">
                          <Clock className="w-5 h-5 text-blue-500 mr-2" />
                          <span className="font-semibold text-blue-700">Upcoming Payments</span>
                        </div>
                        
                        {/* Next Payment - First upcoming with special styling */}
                        {studentProfile.paymentSchedule.upcomingInstallments[0] && (
                          <div className="bg-white rounded-lg p-4 border-2 border-blue-300 mb-3">
                            <div className="flex items-center justify-between">
                              <div className="flex items-center">
                                <div className="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center mr-3">
                                  <span className="text-sm font-bold text-white">NEXT</span>
                                </div>
                                <div>
                                  <p className="text-sm font-semibold text-gray-800">{studentProfile.paymentSchedule.upcomingInstallments[0].description}</p>
                                  <p className="text-xs text-gray-500">Due: {studentProfile.paymentSchedule.upcomingInstallments[0].dateToBePaid ? new Date(studentProfile.paymentSchedule.upcomingInstallments[0].dateToBePaid).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }) : 'N/A'}</p>
                                </div>
                              </div>
                              <div className="text-right">
                                <p className="text-lg font-bold text-gray-800">{formatCurrency(studentProfile.paymentSchedule.upcomingInstallments[0].dueAmount || 0)}</p>
                                {/* Countdown or Due in X days */}
                                <div className="flex items-center justify-end mt-1">
                                  {studentProfile.paymentSchedule.upcomingInstallments[0].showCountdown ? (
                                    <div className="bg-orange-100 text-orange-700 px-2 py-1 rounded text-xs font-bold flex items-center">
                                      <Clock className="w-3 h-3 mr-1" />
                                      <span>{studentProfile.paymentSchedule.upcomingInstallments[0].daysUntilDue} days remaining</span>
                                    </div>
                                  ) : (
                                    <span className="text-xs text-gray-500">Due in {studentProfile.paymentSchedule.upcomingInstallments[0].daysUntilDue} days</span>
                                  )}
                                </div>
                              </div>
                            </div>
                          </div>
                        )}

                        {/* Other Upcoming Payments */}
                        {studentProfile.paymentSchedule.upcomingInstallments.length > 1 && (
                          <div className="space-y-2">
                            {studentProfile.paymentSchedule.upcomingInstallments.slice(1).map((inst, idx) => (
                              <div key={inst.id || idx} className="flex items-center justify-between bg-white rounded-lg px-3 py-2 border border-blue-100">
                                <div className="flex items-center">
                                  <div className="w-8 h-8 bg-gray-100 rounded-full flex items-center justify-center mr-3">
                                    <span className="text-xs font-bold text-gray-600">{idx + 2}</span>
                                  </div>
                                  <div>
                                    <p className="text-sm font-medium text-gray-800">{inst.description}</p>
                                    <p className="text-xs text-gray-500">Due: {inst.dateToBePaid ? new Date(inst.dateToBePaid).toLocaleDateString('en-GB', { day: 'numeric', month: 'short', year: 'numeric' }) : 'N/A'}</p>
                                  </div>
                                </div>
                                <div className="text-right">
                                  <p className="text-sm font-bold text-gray-800">{formatCurrency(inst.dueAmount || 0)}</p>
                                  {inst.showCountdown ? (
                                    <p className="text-xs font-semibold text-orange-600">{inst.daysUntilDue} days remaining</p>
                                  ) : (
                                    <p className="text-xs text-gray-500">Due in {inst.daysUntilDue} days</p>
                                  )}
                                </div>
                              </div>
                            ))}
                          </div>
                        )}
                      </div>
                    )}

                    {/* No pending payments message */}
                    {(!studentProfile.paymentSchedule.overdueInstallments?.length && !studentProfile.paymentSchedule.upcomingInstallments?.length) && (
                      <div className="bg-green-50 border border-green-200 rounded-lg p-4 text-center">
                        <CheckCircle className="w-8 h-8 text-green-500 mx-auto mb-2" />
                        <p className="text-green-700 font-medium">All payments are up to date!</p>
                      </div>
                    )}
                  </div>
                )}

                {/* Progress Bar */}
                <div className="mb-6">
                  <div className="flex justify-between text-sm mb-2">
                    <span className="text-gray-600">Payment Progress</span>
                    <span className="font-medium">{dummyPaymentPlan.planDetails.paidInstallments} of {dummyPaymentPlan.planDetails.numberOfInstallments} installments</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-3">
                    <div 
                      className="bg-gradient-to-r from-green-500 to-green-600 h-3 rounded-full transition-all"
                      style={{ width: `${(dummyPaymentPlan.planDetails.paidInstallments / dummyPaymentPlan.planDetails.numberOfInstallments) * 100}%` }}
                    ></div>
                  </div>
                  <div className="flex justify-between text-xs mt-1">
                    <span className="text-green-600 font-medium">Paid: {formatCurrency(dummyPaymentPlan.planDetails.paidAmount)}</span>
                    <span className="text-orange-600 font-medium">Remaining: {formatCurrency(dummyPaymentPlan.planDetails.dueAmount)}</span>
                  </div>
                </div>

                {/* Payment History - Split into Course Payments, Other Payments, and International/University Fee */}
                <h4 className="font-medium text-gray-700 mb-2">Payment History</h4>
                
                {/* 1. Course Payments (LKR) - Only actual course fee payments */}
                {(() => {
                  // Filter for course fee payments only (exclude Portal Fee, ID Card, Convocation, etc.)
                  const otherPaymentKeywords = ['portal', 'id card', 'convocation', 'registration', 'exam', 'certificate'];
                  const allPayments = studentProfile?.paymentSchedule?.paymentHistory || [];
                  const allLkrPayments = allPayments.filter(p => !p.international);
                  const coursePayments = allLkrPayments.filter(p => {
                    const desc = (p.description || '').toLowerCase();
                    return !otherPaymentKeywords.some(keyword => desc.includes(keyword));
                  });
                  return coursePayments.length > 0 ? (
                    <div className="mb-4">
                      <h5 className="text-sm font-medium text-blue-700 mb-2 flex items-center">
                        <span className="w-2 h-2 bg-blue-500 rounded-full mr-2"></span>
                        Course Payments (LKR)
                      </h5>
                      <div className="overflow-x-auto rounded-lg border border-blue-200 shadow-sm">
                        <table className="w-full text-xs">
                          <thead className="bg-blue-100">
                            <tr>
                              <th className="px-2 py-2 text-left font-medium text-blue-700">#</th>
                              <th className="px-2 py-2 text-left font-medium text-blue-700">Date</th>
                              <th className="px-2 py-2 text-left font-medium text-blue-700">Receipt No</th>
                              <th className="px-2 py-2 text-left font-medium text-blue-700">Description</th>
                              <th className="px-2 py-2 text-right font-medium text-blue-700">Amount (LKR)</th>
                            </tr>
                          </thead>
                          <tbody className="divide-y divide-gray-100 bg-white">
                            {(showAllPayments ? coursePayments : coursePayments.slice(0, 10)).map((inst, idx) => (
                              <tr key={inst.voucherItemId || idx} className="hover:bg-blue-50">
                                <td className="px-2 py-1.5 text-gray-500">{idx + 1}</td>
                                <td className="px-2 py-1.5 text-gray-700">{inst.dueDate || '-'}</td>
                                <td className="px-2 py-1.5 text-gray-500 font-mono text-xs">{inst.voucherItemId || '-'}</td>
                                <td className="px-2 py-1.5 text-gray-600 truncate max-w-[200px]" title={inst.description}>{inst.description || '-'}</td>
                                <td className="px-2 py-1.5 font-medium text-green-600 text-right">{formatCurrency(inst.paidAmount)}</td>
                              </tr>
                            ))}
                            {!showAllPayments && coursePayments.length > 10 && (
                              <tr className="bg-gray-50 cursor-pointer hover:bg-blue-50" onClick={() => setShowAllPayments(true)}>
                                <td colSpan="5" className="px-2 py-1.5 text-center text-blue-600 text-xs font-medium">
                                  Show all {coursePayments.length} payments ▼
                                </td>
                              </tr>
                            )}
                            {showAllPayments && coursePayments.length > 10 && (
                              <tr className="bg-gray-50 cursor-pointer hover:bg-blue-50" onClick={() => setShowAllPayments(false)}>
                                <td colSpan="5" className="px-2 py-1.5 text-center text-blue-600 text-xs font-medium">
                                  Show less ▲
                                </td>
                              </tr>
                            )}
                          </tbody>
                          <tfoot className="bg-blue-50 font-semibold">
                            <tr>
                              <td colSpan="4" className="px-2 py-2 text-blue-700">Total ({coursePayments.length} payments)</td>
                              <td className="px-2 py-2 text-green-700 text-right">
                                {formatCurrency(coursePayments.reduce((sum, i) => sum + (i.paidAmount || 0), 0))}
                              </td>
                            </tr>
                            {(() => {
                              const totalPaid = coursePayments.reduce((sum, i) => sum + (i.paidAmount || 0), 0);
                              const payableCourseFee = studentProfile?.payableCourseFee || 0;
                              const dueAmount = payableCourseFee - totalPaid;
                              return dueAmount > 0 ? (
                                <tr className="bg-red-50">
                                  <td colSpan="4" className="px-2 py-2 text-red-700 font-semibold">Due Amount</td>
                                  <td className="px-2 py-2 text-red-700 text-right font-bold">
                                    {formatCurrency(dueAmount)}
                                  </td>
                                </tr>
                              ) : dueAmount < 0 ? (
                                <tr className="bg-amber-50">
                                  <td colSpan="4" className="px-2 py-2 text-amber-700 font-semibold">Overpayment</td>
                                  <td className="px-2 py-2 text-amber-700 text-right font-bold">
                                    {formatCurrency(Math.abs(dueAmount))}
                                  </td>
                                </tr>
                              ) : null;
                            })()}
                          </tfoot>
                        </table>
                      </div>
                    </div>
                  ) : null;
                })()}
                
                {/* 2. Other Payments (LKR) - Portal Fee, ID Card, Convocation, etc. */}
                {(() => {
                  const otherPaymentKeywords = ['portal', 'id card', 'convocation', 'registration', 'exam', 'certificate'];
                  const allLkrPayments = studentProfile?.paymentSchedule?.paymentHistory?.filter(p => !p.international) || [];
                  const otherPayments = allLkrPayments.filter(p => {
                    const desc = (p.description || '').toLowerCase();
                    return otherPaymentKeywords.some(keyword => desc.includes(keyword));
                  });
                  return otherPayments.length > 0 ? (
                    <div className="mb-4">
                      <h5 className="text-sm font-medium text-teal-700 mb-2 flex items-center">
                        <span className="w-2 h-2 bg-teal-500 rounded-full mr-2"></span>
                        Other Payments (LKR)
                        <span className="ml-2 text-xs text-gray-500 font-normal">(Portal, ID Card, Convocation, etc.)</span>
                      </h5>
                      <div className="overflow-x-auto rounded-lg border border-teal-200 shadow-sm">
                        <table className="w-full text-xs">
                          <thead className="bg-teal-100">
                            <tr>
                              <th className="px-2 py-2 text-left font-medium text-teal-700">#</th>
                              <th className="px-2 py-2 text-left font-medium text-teal-700">Date</th>
                              <th className="px-2 py-2 text-left font-medium text-teal-700">Receipt No</th>
                              <th className="px-2 py-2 text-left font-medium text-teal-700">Description</th>
                              <th className="px-2 py-2 text-right font-medium text-teal-700">Amount (LKR)</th>
                            </tr>
                          </thead>
                          <tbody className="divide-y divide-gray-100 bg-white">
                            {otherPayments.map((inst, idx) => (
                              <tr key={inst.voucherItemId || idx} className="hover:bg-teal-50">
                                <td className="px-2 py-1.5 text-gray-500">{idx + 1}</td>
                                <td className="px-2 py-1.5 text-gray-700">{inst.dueDate || '-'}</td>
                                <td className="px-2 py-1.5 text-gray-500 font-mono text-xs">{inst.voucherItemId || '-'}</td>
                                <td className="px-2 py-1.5 text-gray-600 truncate max-w-[200px]" title={inst.description}>{inst.description || '-'}</td>
                                <td className="px-2 py-1.5 font-medium text-green-600 text-right">{formatCurrency(inst.paidAmount)}</td>
                              </tr>
                            ))}
                          </tbody>
                          <tfoot className="bg-teal-50 font-semibold">
                            <tr>
                              <td colSpan="4" className="px-2 py-2 text-teal-700">Total ({otherPayments.length} payments)</td>
                              <td className="px-2 py-2 text-green-700 text-right">
                                {formatCurrency(otherPayments.reduce((sum, i) => sum + (i.paidAmount || 0), 0))}
                              </td>
                            </tr>
                          </tfoot>
                        </table>
                      </div>
                    </div>
                  ) : null;
                })()}

                {/* 3. International & University Fee (GBP) - Always shown */}
                {(() => {
                  const intlPayments = studentProfile?.paymentSchedule?.paymentHistory?.filter(p => p.international) || [];
                  const coursePaymentsTotal = (studentProfile?.paymentSchedule?.paymentHistory?.filter(p => !p.international) || [])
                    .reduce((sum, i) => sum + (i.paidAmount || 0), 0);
                  const formatGBP = (amount) => new Intl.NumberFormat('en-GB', { style: 'currency', currency: 'GBP' }).format(amount);
                  const isPotentialStudent = coursePaymentsTotal > 1000000 && intlPayments.length === 0;
                  // Clean up description for display
                  const formatIntlDescription = (desc, courseId) => {
                    if (!desc) return '-';
                    const descLower = desc.toLowerCase();
                    // Only change name for Course ID 410 (BEng/BSc International University Payment)
                    if (courseId === 410) {
                      return 'International University Payment';
                    }
                    // Simplify UK Awards names for display
                    if (descLower.includes('level 1')) {
                      return 'UK Awards Level 1';
                    }
                    if (descLower.includes('level 2')) {
                      return 'UK Awards Level 2';
                    }
                    if (descLower.includes('level 3')) {
                      return 'UK Awards Level 3';
                    }
                    return desc;
                  };
                  
                  return (
                    <div className="mb-6">
                      <h5 className="text-sm font-medium text-purple-700 mb-2 flex items-center">
                        <span className="w-2 h-2 bg-purple-500 rounded-full mr-2"></span>
                        International & University Fee (GBP)
                      </h5>
                      
                      {/* Promotional message for potential students */}
                      {isPotentialStudent && (
                        <div className="mb-3 bg-gradient-to-r from-amber-50 to-yellow-50 border border-amber-300 rounded-lg p-3 flex items-center">
                          <span className="text-2xl mr-3">🌟</span>
                          <div>
                            <p className="text-amber-800 font-semibold text-sm">Potential Candidate!</p>
                            <p className="text-amber-700 text-xs">This Student Is a Potential Student to Promote International Certificates/University Degree Certificates</p>
                          </div>
                        </div>
                      )}
                      
                      {intlPayments.length > 0 ? (
                        <div className="overflow-x-auto rounded-lg border border-purple-200 shadow-sm">
                          <table className="w-full text-xs">
                            <thead className="bg-purple-100">
                              <tr>
                                <th className="px-2 py-2 text-left font-medium text-purple-700">#</th>
                                <th className="px-2 py-2 text-left font-medium text-purple-700">Date</th>
                                <th className="px-2 py-2 text-left font-medium text-purple-700">Receipt No</th>
                                <th className="px-2 py-2 text-left font-medium text-purple-700">Description</th>
                                <th className="px-2 py-2 text-right font-medium text-purple-700">GBP</th>
                                <th className="px-2 py-2 text-right font-medium text-purple-700">LKR Equiv.</th>
                                <th className="px-2 py-2 text-center font-medium text-purple-700">Status</th>
                              </tr>
                            </thead>
                            <tbody className="divide-y divide-gray-100 bg-white">
                              {intlPayments.map((inst, idx) => (
                                <tr key={inst.voucherItemId || idx} className="hover:bg-purple-50">
                                  <td className="px-2 py-1.5 text-gray-500">{idx + 1}</td>
                                  <td className="px-2 py-1.5 text-gray-700">{inst.dueDate || '-'}</td>
                                  <td className="px-2 py-1.5 text-gray-500 font-mono text-xs">{inst.voucherItemId || '-'}</td>
                                  <td className="px-2 py-1.5 text-gray-600 truncate max-w-[200px]" title={inst.description}>{formatIntlDescription(inst.description, inst.courseId)}</td>
                                  <td className="px-2 py-1.5 font-medium text-purple-600 text-right">{inst.courseId === 410 ? formatGBP((inst.paidAmount || 0) * 1300 / 530000) : formatGBP(inst.paidAmount)}</td>
                                  <td className="px-2 py-1.5 font-medium text-green-600 text-right">{inst.courseId === 410 ? formatCurrency(inst.paidAmount) : formatCurrency(inst.lkrEquivalent)}</td>
                                  <td className="px-2 py-1.5 text-center">
                                    {(() => {
                                      // Determine payment status based on description and amount
                                      const desc = (inst.description || '').toLowerCase();
                                      const amount = inst.paidAmount || 0;
                                      
                                      // UK Awards: Level 1 = £100, Level 2 = £110, Level 3 = £130
                                      if (desc.includes('level 1')) {
                                        return amount >= 100 
                                          ? <span className="bg-green-500 text-white text-xs px-1.5 py-0.5 rounded-full">Full</span>
                                          : <span className="bg-yellow-500 text-white text-xs px-1.5 py-0.5 rounded-full">Partial</span>;
                                      }
                                      if (desc.includes('level 2')) {
                                        return amount >= 110 
                                          ? <span className="bg-green-500 text-white text-xs px-1.5 py-0.5 rounded-full">Full</span>
                                          : <span className="bg-yellow-500 text-white text-xs px-1.5 py-0.5 rounded-full">Partial</span>;
                                      }
                                      if (desc.includes('level 3')) {
                                        return amount >= 130 
                                          ? <span className="bg-green-500 text-white text-xs px-1.5 py-0.5 rounded-full">Full</span>
                                          : <span className="bg-yellow-500 text-white text-xs px-1.5 py-0.5 rounded-full">Partial</span>;
                                      }
                                      
                                      // Course ID 410 (University Degree Fee - LKR 530,000)
                                      if (inst.courseId === 410) {
                                        // Check total paid for Course ID 410
                                        const total410Paid = intlPayments
                                          .filter(p => p.courseId === 410)
                                          .reduce((sum, p) => sum + (p.paidAmount || 0), 0);
                                        return total410Paid >= 530000 
                                          ? <span className="bg-green-500 text-white text-xs px-1.5 py-0.5 rounded-full">Full</span>
                                          : <span className="bg-yellow-500 text-white text-xs px-1.5 py-0.5 rounded-full">Partial</span>;
                                      }
                                      
                                      // Default: assume full if amount > 0
                                      return amount > 0 
                                        ? <span className="bg-green-500 text-white text-xs px-1.5 py-0.5 rounded-full">Full</span>
                                        : <span className="bg-gray-400 text-white text-xs px-1.5 py-0.5 rounded-full">-</span>;
                                    })()}
                                  </td>
                                </tr>
                              ))}
                            </tbody>
                            <tfoot className="bg-purple-50 font-semibold">
                              <tr>
                                <td colSpan="4" className="px-2 py-2 text-purple-700">Total ({intlPayments.length} payments)</td>
                                <td></td>
                                <td className="px-2 py-2 text-purple-700 text-right">
                                  {formatGBP(
                                    intlPayments.filter(i => i.courseId !== 410).reduce((sum, i) => sum + (i.paidAmount || 0), 0) +
                                    intlPayments.filter(i => i.courseId === 410).reduce((sum, i) => sum + ((i.paidAmount || 0) * 1300 / 530000), 0)
                                  )}
                                </td>
                                <td className="px-2 py-2 text-green-700 text-right">
                                  {formatCurrency(intlPayments.reduce((sum, i) => sum + (i.courseId === 410 ? (i.paidAmount || 0) : (i.lkrEquivalent || 0)), 0))}
                                </td>
                              </tr>
                              {(() => {
                                // Calculate due for Course ID 410 (International University Payment - LKR 530,000)
                                const course410Payments = intlPayments.filter(i => i.courseId === 410);
                                const course410Paid = course410Payments.reduce((sum, i) => sum + (i.paidAmount || 0), 0);
                                const course410Fee = 530000; // Standard fee for Course ID 410
                                const course410Due = course410Payments.length > 0 ? course410Fee - course410Paid : 0;
                                
                                // Calculate due for GBP payments (UK Awards: Level 1=£110, Level 2=£120, Level 3=£140 = Total £370)
                                const gbpPayments = intlPayments.filter(i => i.courseId !== 410);
                                const gbpPaid = gbpPayments.reduce((sum, i) => sum + (i.paidAmount || 0), 0);
                                const gbpFee = 370; // Total GBP fee for UK Awards
                                const gbpDue = gbpPayments.length > 0 ? gbpFee - gbpPaid : 0;
                                
                                // Convert Course 410 due to GBP equivalent
                                const course410DueGbp = course410Due > 0 ? (course410Due * 1300 / 530000) : 0;
                                const totalDueGbp = gbpDue + course410DueGbp;
                                
                                // Calculate total LKR due (GBP due converted + Course 410 LKR due)
                                const gbpDueLkr = gbpDue > 0 && gbpToLkrRate ? gbpDue * gbpToLkrRate : 0;
                                const totalDueLkr = gbpDueLkr + course410Due;
                                
                                return (course410Due > 0 || gbpDue > 0) ? (
                                  <tr className="bg-red-50">
                                    <td colSpan="4" className="px-2 py-2 text-red-700 font-semibold">Due Amount</td>
                                    <td></td>
                                    <td className="px-2 py-2 text-red-700 text-right font-bold">
                                      {totalDueGbp > 0 ? formatGBP(totalDueGbp) : '-'}
                                    </td>
                                    <td className="px-2 py-2 text-red-700 text-right font-bold">
                                      {totalDueLkr > 0 ? formatCurrency(totalDueLkr) : '-'}
                                    </td>
                                  </tr>
                                ) : null;
                              })()}
                            </tfoot>
                          </table>
                        </div>
                      ) : (
                        <div className="bg-purple-50 border border-purple-200 rounded-lg p-3 text-center text-purple-600 text-sm">
                          No international payments recorded
                        </div>
                      )}
                      
                      {/* Pending International/University Payments - 5 Categories */}
                      {(() => {
                        // Payment Categories:
                        // 1. UK Award Level 1 & 2 (£100 + £110 = £210)
                        // 2. UK Award Level 3 (£130)
                        // 3. IIC Payment (International Industry Certificate)
                        // 4. BCU Degree Payment (Birmingham City University)
                        // 5. IIC and BCU Both Payments
                        
                        // Count GBP payments (UK Awards) - exclude Course ID 410
                        const gbpPayments = intlPayments.filter(p => p.courseId !== 410);
                        const gbpPaidCount = gbpPayments.length;
                        
                        // Check Course ID 410 payments (LKR payments for University Degree Fee)
                        const course410Payments = intlPayments.filter(p => p.courseId === 410);
                        const course410Paid = course410Payments.reduce((sum, p) => sum + (p.paidAmount || 0), 0);
                        const course410Fee = 530000; // Standard fee for Course ID 410 (LKR)
                        const universityFeePaidInLkr = course410Paid > 0;
                        const universityFeeFullyPaid = course410Paid >= course410Fee;
                        const universityFeeDueLkr = universityFeePaidInLkr ? Math.max(0, course410Fee - course410Paid) : 0;
                        
                        // Check for specific UK Awards payments by description
                        const hasLevel1 = gbpPayments.some(p => (p.description || '').toLowerCase().includes('level 1'));
                        const hasLevel2 = gbpPayments.some(p => (p.description || '').toLowerCase().includes('level 2'));
                        const hasLevel3 = gbpPayments.some(p => (p.description || '').toLowerCase().includes('level 3'));
                        
                        // Calculate paid amounts for Level 1 & 2
                        const level1Payment = gbpPayments.find(p => (p.description || '').toLowerCase().includes('level 1'));
                        const level2Payment = gbpPayments.find(p => (p.description || '').toLowerCase().includes('level 2'));
                        const level3Payment = gbpPayments.find(p => (p.description || '').toLowerCase().includes('level 3'));
                        const level1Paid = level1Payment ? (level1Payment.paidAmount || 0) : 0;
                        const level2Paid = level2Payment ? (level2Payment.paidAmount || 0) : 0;
                        const level3Paid = level3Payment ? (level3Payment.paidAmount || 0) : 0;
                        const level12TotalPaid = level1Paid + level2Paid;
                        const level12Fee = 210; // £100 + £110
                        const level12FullyPaid = hasLevel1 && hasLevel2;
                        const level12PartiallyPaid = hasLevel1 || hasLevel2;
                        const level12Due = level12Fee - level12TotalPaid;
                        
                        // Level 3 is optional - only show as paid if paid, no due shown
                        const level3FullyPaid = hasLevel3 && level3Paid >= 130;
                        
                        // Check branch - UK Award Level 1 & 2 is optional for IIC and Colombo Head Office
                        const branchName = studentProfile?.branchName || '';
                        const isLevel12Optional = branchName.toLowerCase().includes('iic') || 
                                                  branchName.toLowerCase().includes('colombo head office');
                        
                        // Define the 5 payment categories with their details
                        const paymentCategories = [
                          {
                            id: 1,
                            title: 'UK Award Level 1 & 2',
                            description: isLevel12Optional 
                              ? `International Certificate - Level 4 & 5 (Optional - ${branchName})`
                              : 'International Certificate - Level 4 & 5',
                            icon: '🏅',
                            amountGbp: 210,
                            amountLkr: null,
                            bgClass: level12FullyPaid 
                              ? 'bg-gradient-to-br from-green-50 to-green-100 border-green-400' 
                              : level12PartiallyPaid 
                                ? 'bg-gradient-to-br from-yellow-50 to-yellow-100 border-yellow-400'
                                : isLevel12Optional
                                  ? 'bg-gradient-to-br from-gray-50 to-gray-100 border-gray-300'
                                  : 'bg-gradient-to-br from-blue-50 to-blue-100 border-blue-300',
                            textClass: level12FullyPaid ? 'text-green-800' : level12PartiallyPaid ? 'text-yellow-800' : isLevel12Optional ? 'text-gray-800' : 'text-blue-800',
                            descClass: level12FullyPaid ? 'text-green-600' : level12PartiallyPaid ? 'text-yellow-600' : isLevel12Optional ? 'text-gray-600' : 'text-blue-600',
                            amountClass: level12FullyPaid ? 'text-green-700' : level12PartiallyPaid ? 'text-yellow-700' : isLevel12Optional ? 'text-gray-700' : 'text-blue-700',
                            isPaid: level12FullyPaid,
                            isPartial: level12PartiallyPaid && !level12FullyPaid && !isLevel12Optional,
                            isOptional: isLevel12Optional && !level12FullyPaid && !level12PartiallyPaid,
                            paidAmount: level12TotalPaid,
                            dueAmount: isLevel12Optional ? 0 : (level12Due > 0 ? level12Due : 0)
                          },
                          {
                            id: 2,
                            title: 'UK Award Level 3',
                            description: 'International Certificate - Level 6 (Optional)',
                            icon: '🎖️',
                            amountGbp: 130,
                            amountLkr: null,
                            bgClass: level3FullyPaid 
                              ? 'bg-gradient-to-br from-green-50 to-green-100 border-green-400' 
                              : 'bg-gradient-to-br from-indigo-50 to-indigo-100 border-indigo-300',
                            textClass: level3FullyPaid ? 'text-green-800' : 'text-indigo-800',
                            descClass: level3FullyPaid ? 'text-green-600' : 'text-indigo-600',
                            amountClass: level3FullyPaid ? 'text-green-700' : 'text-indigo-700',
                            isPaid: level3FullyPaid,
                            isOptional: true,
                            paidAmount: level3Paid
                          },
                          {
                            id: 3,
                            title: student?.internationalPaymentType === 'IIC' ? 'IIC Payment' 
                                 : student?.internationalPaymentType === 'BCU' ? 'BCU Degree Payment'
                                 : student?.internationalPaymentType === 'CHO' ? 'No Intl Payment'
                                 : 'Intl Payment (TBD)',
                            description: student?.internationalPaymentType === 'IIC' ? 'International Industry Certificate'
                                       : student?.internationalPaymentType === 'BCU' ? 'Birmingham City University'
                                       : student?.internationalPaymentType === 'CHO' ? 'Colombo Head Office - No Payment'
                                       : 'Branch not assigned for international payment',
                            icon: student?.internationalPaymentType === 'BCU' ? '🎓' : '📜',
                            amountGbp: student?.internationalPaymentType === 'IIC' ? 500 
                                     : student?.internationalPaymentType === 'BCU' ? 1300 
                                     : null,
                            amountLkr: (student?.intlDueAmount || 0) > 0 ? student?.intlDueAmount : null,
                            bgClass: student?.internationalPaymentType === 'CHO' 
                              ? 'bg-gradient-to-br from-gray-50 to-gray-100 border-gray-300'
                              : student?.internationalPaymentType === 'NONE'
                              ? 'bg-gradient-to-br from-yellow-50 to-yellow-100 border-yellow-300'
                              : (student?.intlDueAmount || 0) > 0 
                                ? 'bg-gradient-to-br from-orange-50 to-orange-100 border-orange-400' 
                                : (student?.intlPaidAmount || 0) > 0
                                ? 'bg-gradient-to-br from-green-50 to-green-100 border-green-300'
                                : 'bg-gradient-to-br from-purple-50 to-purple-100 border-purple-300',
                            textClass: student?.internationalPaymentType === 'CHO' ? 'text-gray-800'
                              : student?.internationalPaymentType === 'NONE' ? 'text-yellow-800'
                              : (student?.intlDueAmount || 0) > 0 ? 'text-orange-800' 
                              : (student?.intlPaidAmount || 0) > 0 ? 'text-green-800'
                              : 'text-purple-800',
                            descClass: student?.internationalPaymentType === 'CHO' ? 'text-gray-600'
                              : student?.internationalPaymentType === 'NONE' ? 'text-yellow-600'
                              : (student?.intlDueAmount || 0) > 0 ? 'text-orange-600' 
                              : (student?.intlPaidAmount || 0) > 0 ? 'text-green-600'
                              : 'text-purple-600',
                            amountClass: student?.internationalPaymentType === 'CHO' ? 'text-gray-700'
                              : student?.internationalPaymentType === 'NONE' ? 'text-yellow-700'
                              : (student?.intlDueAmount || 0) > 0 ? 'text-orange-700' 
                              : (student?.intlPaidAmount || 0) > 0 ? 'text-green-700'
                              : 'text-purple-700',
                            intlPaymentType: student?.internationalPaymentType || 'NONE',
                            intlFeeAmount: student?.intlFeeAmount || 0,
                            intlPaidAmount: student?.intlPaidAmount || 0,
                            intlDueAmount: student?.intlDueAmount || 0,
                            isPaid: ['IIC', 'BCU'].includes(student?.internationalPaymentType) && (student?.intlPaidAmount || 0) > 0 && (student?.intlDueAmount || 0) === 0,
                            isPartial: ['IIC', 'BCU'].includes(student?.internationalPaymentType) && (student?.intlPaidAmount || 0) > 0 && (student?.intlDueAmount || 0) > 0,
                            isNotEnrolled: student?.internationalPaymentType === 'CHO',
                            isNotDecided: student?.internationalPaymentType === 'NONE'
                          },
                          {
                            id: 4,
                            title: 'BCU Degree Payment',
                            description: 'Birmingham City University Degree',
                            icon: '🎓',
                            amountGbp: 1300,
                            amountLkr: null,
                            bgClass: 'bg-gradient-to-br from-red-50 to-red-100 border-red-300',
                            textClass: 'text-red-800',
                            descClass: 'text-red-600',
                            amountClass: 'text-red-700'
                          },
                          {
                            id: 5,
                            title: 'IIC + BCU Combined',
                            description: 'Both IIC and BCU Degree Payments',
                            icon: '🏆',
                            amountGbp: 1800,
                            amountLkr: null,
                            bgClass: 'bg-gradient-to-br from-amber-50 to-amber-100 border-amber-300',
                            textClass: 'text-amber-800',
                            descClass: 'text-amber-600',
                            amountClass: 'text-amber-700'
                          }
                        ];
                        
                        // Calculate totals (keeping existing logic for now)
                        let pendingItems = [];
                        let pendingTotalGbp = 0;
                        let pendingTotalLkr = 0;
                        
                        if (gbpPaidCount === 0) {
                          pendingItems.push({ name: 'UK Awards Level 1', amountGbp: 100, amountLkr: null });
                          pendingItems.push({ name: 'UK Awards Level 2', amountGbp: 110, amountLkr: null });
                          pendingItems.push({ name: 'UK Awards Level 3', amountGbp: 130, amountLkr: null });
                          pendingTotalGbp = 340;
                        } else if (gbpPaidCount === 1) {
                          pendingItems.push({ name: 'UK Awards Level 2', amountGbp: 110, amountLkr: null });
                          pendingItems.push({ name: 'UK Awards Level 3', amountGbp: 130, amountLkr: null });
                          pendingTotalGbp = 240;
                        } else if (gbpPaidCount === 2) {
                          pendingItems.push({ name: 'UK Awards Level 3', amountGbp: 130, amountLkr: null });
                          pendingTotalGbp = 130;
                        }
                        
                        if (!universityFeePaidInLkr) {
                          pendingItems.push({ name: 'University Degree Fee', amountGbp: 1300, amountLkr: null });
                          pendingTotalGbp += 1300;
                        } else if (!universityFeeFullyPaid) {
                          pendingItems.push({ name: 'University Degree Fee (Remaining)', amountGbp: null, amountLkr: universityFeeDueLkr });
                          pendingTotalLkr = universityFeeDueLkr;
                        }
                        
                        const lkrTotalFromGbp = gbpToLkrRate ? pendingTotalGbp * gbpToLkrRate : 0;
                        const grandTotalLkr = lkrTotalFromGbp + pendingTotalLkr;
                        
                        return (
                          <div className="mt-3 space-y-3">
                            {/* Payment Categories Grid */}
                            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-2">
                              {paymentCategories.map((cat) => (
                                <div 
                                  key={cat.id} 
                                  className={`${cat.bgClass} border rounded-lg p-3 hover:shadow-md transition-shadow`}
                                >
                                  <div className="flex items-start">
                                    <span className="text-xl mr-2">{cat.icon}</span>
                                    <div className="flex-1">
                                      <div className="flex justify-between items-start">
                                        <p className={`${cat.textClass} font-semibold text-sm`}>{cat.title}</p>
                                        {cat.isPaid && (
                                          <span className="bg-green-500 text-white text-xs px-2 py-0.5 rounded-full font-medium">✓ PAID</span>
                                        )}
                                        {cat.isPartial && (
                                          <span className="bg-yellow-500 text-white text-xs px-2 py-0.5 rounded-full font-medium">PARTIAL</span>
                                        )}
                                        {cat.isOptional && !cat.isPaid && (
                                          <span className="bg-gray-400 text-white text-xs px-2 py-0.5 rounded-full font-medium">OPTIONAL</span>
                                        )}
                                        {cat.isNotEnrolled && (
                                          <span className="bg-gray-400 text-white text-xs px-2 py-0.5 rounded-full font-medium">N/A</span>
                                        )}
                                        {cat.isNotDecided && (
                                          <span className="bg-yellow-500 text-white text-xs px-2 py-0.5 rounded-full font-medium">TBD</span>
                                        )}
                                      </div>
                                      <p className={`${cat.descClass} text-xs`}>{cat.description}</p>
                                      <div className="mt-2">
                                        {cat.isPaid ? (
                                          <div className="flex justify-between items-center">
                                            <span className="text-green-700 font-bold">
                                              Paid: £{cat.paidAmount?.toLocaleString()} GBP
                                            </span>
                                            {gbpToLkrRate && (
                                              <span className="text-green-600 text-xs">
                                                ≈ {formatCurrency(cat.paidAmount * gbpToLkrRate)}
                                              </span>
                                            )}
                                          </div>
                                        ) : cat.isPartial ? (
                                          <div className="space-y-1">
                                            <div className="flex justify-between items-center text-xs">
                                              <span className="text-green-700">Paid: £{cat.paidAmount?.toLocaleString()}</span>
                                              {gbpToLkrRate && <span className="text-green-600">≈ {formatCurrency(cat.paidAmount * gbpToLkrRate)}</span>}
                                            </div>
                                            <div className="flex justify-between items-center">
                                              <span className="text-red-700 font-bold">Due: £{cat.dueAmount?.toLocaleString()} GBP</span>
                                              {gbpToLkrRate && <span className="text-red-600 text-xs">≈ {formatCurrency(cat.dueAmount * gbpToLkrRate)}</span>}
                                            </div>
                                          </div>
                                        ) : cat.isOptional ? (
                                          <div className="flex justify-between items-center">
                                            <span className={`${cat.amountClass} font-bold`}>
                                              £{cat.amountGbp?.toLocaleString()} GBP
                                            </span>
                                            <span className="text-gray-500 text-xs italic">Not required</span>
                                          </div>
                                        ) : cat.isNotEnrolled ? (
                                          <div className="flex justify-between items-center">
                                            <span className={`${cat.amountClass} font-bold`}>No Payment Required</span>
                                            <span className="text-gray-500 text-xs italic">CHO Branch</span>
                                          </div>
                                        ) : cat.isNotDecided ? (
                                          <div className="flex justify-between items-center">
                                            <span className={`${cat.amountClass} font-bold`}>Pending Assignment</span>
                                            <span className="text-yellow-600 text-xs italic">Branch TBD</span>
                                          </div>
                                        ) : cat.intlPaymentType && ['IIC', 'BCU'].includes(cat.intlPaymentType) && (cat.intlDueAmount || 0) > 0 ? (
                                          <div className="space-y-1">
                                            <div className="flex justify-between items-center text-xs">
                                              <span className="text-green-700">Paid: {formatCurrency(cat.intlPaidAmount || 0)}</span>
                                              <span className="text-gray-500">of {formatCurrency(cat.intlFeeAmount || 0)}</span>
                                            </div>
                                            <div className="flex justify-between items-center">
                                              <span className="text-orange-700 font-bold text-lg">Due: {formatCurrency(cat.intlDueAmount || 0)}</span>
                                            </div>
                                          </div>
                                        ) : cat.intlPaymentType && ['IIC', 'BCU'].includes(cat.intlPaymentType) && (cat.intlPaidAmount || 0) > 0 ? (
                                          <div className="flex justify-between items-center">
                                            <span className="text-green-700 font-bold">
                                              Paid: {formatCurrency(cat.intlPaidAmount || cat.intlFeeAmount || 0)}
                                            </span>
                                            <span className="text-green-600 text-xs">Fully Paid</span>
                                          </div>
                                        ) : (
                                          <div className="flex justify-between items-center">
                                            <span className={`${cat.amountClass} font-bold`}>
                                              £{cat.amountGbp?.toLocaleString()} GBP
                                            </span>
                                            {gbpToLkrRate && (
                                              <span className="text-green-600 text-xs">
                                                ≈ {formatCurrency(cat.amountGbp * gbpToLkrRate)}
                                              </span>
                                            )}
                                          </div>
                                        )}
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              ))}
                            </div>
                            
                            {/* Pending Payments Summary */}
                            {pendingItems.length > 0 && (
                              <div className="bg-gradient-to-r from-red-50 to-orange-50 border border-red-300 rounded-lg p-3">
                                <div className="flex items-center mb-2">
                                  <span className="text-2xl mr-3">⚠️</span>
                                  <div>
                                    <p className="text-red-800 font-semibold text-sm">Pending Payments for This Student</p>
                                    <p className="text-red-700 text-xs">
                                      Total Outstanding: 
                                      {pendingTotalGbp > 0 && <span className="font-bold text-lg ml-1">£{pendingTotalGbp.toLocaleString()} GBP</span>}
                                      {pendingTotalLkr > 0 && <span className="font-bold text-lg ml-1">{pendingTotalGbp > 0 ? ' + ' : ''}{formatCurrency(pendingTotalLkr)}</span>}
                                      {grandTotalLkr > 0 && (
                                        <span className="ml-2 text-green-700 font-bold">≈ {formatCurrency(grandTotalLkr)}</span>
                                      )}
                                    </p>
                                  </div>
                                </div>
                                <div className="mt-2 pl-9 space-y-1">
                                  {pendingItems.map((item, idx) => (
                                    <div key={idx} className="flex justify-between text-xs">
                                      <span className="text-red-700">• {item.name}</span>
                                      <div className="text-right">
                                        {item.amountGbp !== null ? (
                                          <>
                                            <span className="font-medium text-red-800">£{item.amountGbp.toLocaleString()}</span>
                                            {gbpToLkrRate && (
                                              <span className="ml-2 text-green-700 text-xs">≈ {formatCurrency(item.amountGbp * gbpToLkrRate)}</span>
                                            )}
                                          </>
                                        ) : (
                                          <span className="font-medium text-red-800">{formatCurrency(item.amountLkr)}</span>
                                        )}
                                      </div>
                                    </div>
                                  ))}
                                </div>
                                {gbpToLkrRate && pendingTotalGbp > 0 && (
                                  <div className="mt-2 pt-2 border-t border-red-200 text-xs text-gray-500 pl-9">
                                    Exchange Rate: 1 GBP = {gbpToLkrRate.toFixed(2)} LKR (Live)
                                  </div>
                                )}
                              </div>
                            )}
                          </div>
                        );
                      })()}
                    </div>
                  );
                })()}

                {/* No payment history message */}
                {(!studentProfile?.paymentSchedule?.paymentHistory || studentProfile.paymentSchedule.paymentHistory.length === 0) && (
                  <div className="bg-gray-50 border rounded-lg p-3 text-center text-gray-500 text-sm mb-6">
                    No payment history found
                  </div>
                )}

                {/* Payment Manager History Table (for comparison) */}
                <h4 className="font-medium text-gray-700 mb-3 flex items-center">
                  student_payment_manager Records
                  <span className="ml-2 text-xs text-gray-400 font-normal">(for comparison)</span>
                </h4>
                {studentProfile?.paymentSchedule?.paymentManagerHistory?.length > 0 ? (
                  <div className="overflow-x-auto rounded-lg border mb-6">
                    <table className="w-full">
                      <thead className="bg-purple-50">
                        <tr>
                          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">#</th>
                          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Paid Date</th>
                          <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase">Entered Amount</th>
                          <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase">Approved Amount</th>
                          <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Status</th>
                          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Document</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-gray-200 bg-white">
                        {studentProfile.paymentSchedule.paymentManagerHistory.map((pm, idx) => (
                          <tr key={pm.id || idx} className="hover:bg-gray-50">
                            <td className="px-4 py-3 text-sm text-gray-500">{idx + 1}</td>
                            <td className="px-4 py-3 text-sm text-gray-700">{pm.paidDate || '-'}</td>
                            <td className="px-4 py-3 text-sm font-semibold text-purple-600 text-right">{formatCurrency(pm.enteredAmount)}</td>
                            <td className="px-4 py-3 text-sm text-right">
                              {pm.approvedAmount ? formatCurrency(pm.approvedAmount) : <span className="text-gray-400">-</span>}
                            </td>
                            <td className="px-4 py-3 text-center">
                              {pm.isApproved === 1 ? (
                                <span className="px-2 py-1 text-xs font-medium bg-green-100 text-green-700 rounded-full">Approved</span>
                              ) : (
                                <span className="px-2 py-1 text-xs font-medium bg-yellow-100 text-yellow-700 rounded-full">Pending</span>
                              )}
                            </td>
                            <td className="px-4 py-3 text-sm text-gray-500 max-w-[200px] truncate" title={pm.document}>
                              {pm.document ? pm.document.split('-').pop() : '-'}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                      <tfoot className="bg-gray-100 font-semibold">
                        <tr>
                          <td colSpan="2" className="px-4 py-3 text-sm text-gray-700">Total</td>
                          <td className="px-4 py-3 text-sm text-purple-600 text-right">
                            {formatCurrency(studentProfile.paymentSchedule.paymentManagerHistory.reduce((sum, pm) => sum + (pm.enteredAmount || 0), 0))}
                          </td>
                          <td colSpan="3" className="px-4 py-3"></td>
                        </tr>
                      </tfoot>
                    </table>
                    
                    {/* Comparison Summary */}
                    {studentProfile.paymentSchedule.paymentHistory?.length > 0 && (
                      <div className="bg-gray-50 border-t p-4">
                        <div className="flex items-center justify-between text-sm">
                          <div>
                            <span className="text-gray-600">Scheduler Total Paid: </span>
                            <span className="font-semibold text-green-600">
                              {formatCurrency(studentProfile.paymentSchedule.paymentHistory.reduce((sum, i) => sum + (i.paidAmount || 0), 0))}
                            </span>
                          </div>
                          <div>
                            <span className="text-gray-600">Payment Manager Total: </span>
                            <span className="font-semibold text-purple-600">
                              {formatCurrency(studentProfile.paymentSchedule.paymentManagerHistory.reduce((sum, pm) => sum + (pm.enteredAmount || 0), 0))}
                            </span>
                          </div>
                          <div>
                            <span className="text-gray-600">Discrepancy: </span>
                            {(() => {
                              const schedulerTotal = studentProfile.paymentSchedule.paymentHistory.reduce((sum, i) => sum + (i.paidAmount || 0), 0);
                              const managerTotal = studentProfile.paymentSchedule.paymentManagerHistory.reduce((sum, pm) => sum + (pm.enteredAmount || 0), 0);
                              const diff = managerTotal - schedulerTotal;
                              return (
                                <span className={`font-semibold ${Math.abs(diff) > 0 ? 'text-red-600' : 'text-green-600'}`}>
                                  {Math.abs(diff) > 0 ? formatCurrency(diff) : 'None'}
                                </span>
                              );
                            })()}
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                ) : (
                  <div className="bg-gray-50 border rounded-lg p-4 text-center text-gray-500 mb-6">
                    No payment manager records found
                  </div>
                )}

                {/* Payment Schedule Table */}
                <h4 className="font-medium text-gray-700 mb-3">Payment Schedule</h4>
                {studentProfile?.paymentSchedule?.pendingInstallments?.length > 0 ? (
                  <div className="overflow-x-auto rounded-lg border">
                    <table className="w-full">
                      <thead className="bg-orange-50">
                        <tr>
                          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">#</th>
                          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Due Date</th>
                          <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase">Payment</th>
                          <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase">Paid</th>
                          <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase">Due Amount</th>
                          <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Days Overdue</th>
                          <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Status</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-gray-200 bg-white">
                        {studentProfile.paymentSchedule.pendingInstallments.map((inst, idx) => (
                          <tr key={inst.installmentId || idx} className={`hover:bg-gray-50 ${inst.status === 'OVERDUE' ? 'bg-red-50' : inst.status === 'PARTIAL' ? 'bg-yellow-50' : ''}`}>
                            <td className="px-4 py-3 text-sm text-gray-500">{idx + 1}</td>
                            <td className="px-4 py-3 text-sm text-gray-700">{inst.dueDate || '-'}</td>
                            <td className="px-4 py-3 text-sm text-gray-700 text-right">{formatCurrency(inst.toBePaidAmount)}</td>
                            <td className="px-4 py-3 text-sm text-green-600 text-right">{formatCurrency(inst.paidAmount)}</td>
                            <td className="px-4 py-3 text-sm font-semibold text-red-600 text-right">{formatCurrency(inst.dueAmount)}</td>
                            <td className="px-4 py-3 text-sm text-center">
                              {inst.daysOverdue > 0 ? (
                                <span className="text-red-600 font-medium">{inst.daysOverdue} days</span>
                              ) : (
                                <span className="text-gray-400">-</span>
                              )}
                            </td>
                            <td className="px-4 py-3 text-center">
                              {inst.status === 'OVERDUE' && <span className="px-2 py-1 text-xs font-medium bg-red-100 text-red-700 rounded-full">Overdue</span>}
                              {inst.status === 'PARTIAL' && <span className="px-2 py-1 text-xs font-medium bg-yellow-100 text-yellow-700 rounded-full">Partial</span>}
                              {inst.status === 'PENDING' && <span className="px-2 py-1 text-xs font-medium bg-blue-100 text-blue-700 rounded-full">Pending</span>}
                            </td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                ) : (
                  <div className="bg-green-50 border border-green-200 rounded-lg p-4 text-center">
                    <CheckCircle className="w-6 h-6 text-green-500 mx-auto mb-2" />
                    <p className="text-green-700 font-medium">All installments are paid!</p>
                  </div>
                )}
              </div>
            </div>

            {/* Segment 5: Other Payments (International, University, Portal) */}
            <div className="card border-t-4 border-t-violet-500 lg:col-span-2">
              <div className="card-header bg-violet-50">
                <div className="flex items-center">
                  <div className="w-10 h-10 bg-violet-500 rounded-lg flex items-center justify-center mr-3">
                    <Globe className="w-5 h-5 text-white" />
                  </div>
                  <div>
                    <h2 className="text-lg font-semibold text-gray-900">Other Payments</h2>
                    <p className="text-sm text-gray-500">International, University & Portal fees</p>
                  </div>
                </div>
              </div>
              <div className="card-body p-0">
                {/* Tabs */}
                <div className="border-b overflow-x-auto bg-gray-50">
                  <div className="flex">
                    <button onClick={() => setActiveOtherPaymentTab('internationalDiploma')} className={`px-4 py-3 text-sm font-medium whitespace-nowrap border-b-2 transition-colors ${activeOtherPaymentTab === 'internationalDiploma' ? 'border-purple-500 text-purple-700 bg-purple-50' : 'border-transparent text-gray-500 hover:bg-gray-100'}`}>
                      <Globe className="w-4 h-4 inline mr-1" /> Int'l Diploma
                    </button>
                    <button onClick={() => setActiveOtherPaymentTab('internationalHigherDiploma')} className={`px-4 py-3 text-sm font-medium whitespace-nowrap border-b-2 transition-colors ${activeOtherPaymentTab === 'internationalHigherDiploma' ? 'border-violet-500 text-violet-700 bg-violet-50' : 'border-transparent text-gray-500 hover:bg-gray-100'}`}>
                      <Award className="w-4 h-4 inline mr-1" /> Int'l Higher Diploma
                    </button>
                    <button onClick={() => setActiveOtherPaymentTab('universityPayment')} className={`px-4 py-3 text-sm font-medium whitespace-nowrap border-b-2 transition-colors ${activeOtherPaymentTab === 'universityPayment' ? 'border-rose-500 text-rose-700 bg-rose-50' : 'border-transparent text-gray-500 hover:bg-gray-100'}`}>
                      <GraduationCap className="w-4 h-4 inline mr-1" /> University
                    </button>
                    <button onClick={() => setActiveOtherPaymentTab('portalPayments')} className={`px-4 py-3 text-sm font-medium whitespace-nowrap border-b-2 transition-colors ${activeOtherPaymentTab === 'portalPayments' ? 'border-amber-500 text-amber-700 bg-amber-50' : 'border-transparent text-gray-500 hover:bg-gray-100'}`}>
                      <Laptop className="w-4 h-4 inline mr-1" /> Portal (Y1, Y2, Y3)
                    </button>
                  </div>
                </div>

                {/* Tab Content */}
                <div className="p-4">
                  {/* Summary for active tab */}
                  <div className="grid grid-cols-3 gap-4 mb-4">
                    <div className="bg-gray-50 rounded-lg p-3 text-center">
                      <p className="text-xs text-gray-500">Total</p>
                      <p className="text-lg font-bold text-gray-900">{formatCurrency(dummyOtherPayments[activeOtherPaymentTab]?.total || 0)}</p>
                    </div>
                    <div className="bg-green-50 rounded-lg p-3 text-center">
                      <p className="text-xs text-gray-500">Paid</p>
                      <p className="text-lg font-bold text-green-600">{formatCurrency(dummyOtherPayments[activeOtherPaymentTab]?.paid || 0)}</p>
                    </div>
                    <div className="bg-orange-50 rounded-lg p-3 text-center">
                      <p className="text-xs text-gray-500">Due</p>
                      <p className="text-lg font-bold text-orange-600">{formatCurrency((dummyOtherPayments[activeOtherPaymentTab]?.total || 0) - (dummyOtherPayments[activeOtherPaymentTab]?.paid || 0))}</p>
                    </div>
                  </div>

                  {/* Payments Table */}
                  <div className="overflow-x-auto rounded-lg border">
                    <table className="w-full">
                      <thead className="bg-gray-50">
                        <tr>
                          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
                          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Description</th>
                          <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Method</th>
                          <th className="px-4 py-3 text-right text-xs font-medium text-gray-500 uppercase">Amount</th>
                          <th className="px-4 py-3 text-center text-xs font-medium text-gray-500 uppercase">Status</th>
                        </tr>
                      </thead>
                      <tbody className="divide-y divide-gray-200 bg-white">
                        {dummyOtherPayments[activeOtherPaymentTab]?.payments.map((payment) => (
                          <tr key={payment.id} className="hover:bg-gray-50">
                            <td className="px-4 py-3 text-sm text-gray-500">{payment.date}</td>
                            <td className="px-4 py-3 text-sm font-medium text-gray-900">{payment.description}</td>
                            <td className="px-4 py-3 text-sm text-gray-500">{payment.method}</td>
                            <td className="px-4 py-3 text-sm font-semibold text-gray-900 text-right">{formatCurrency(payment.amount)}</td>
                            <td className="px-4 py-3 text-center">{getStatusBadge(payment.status)}</td>
                          </tr>
                        ))}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>

          </div>
        </div>
      )}
    </div>
  )
}
