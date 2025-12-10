import { useParams, Link } from 'react-router-dom'
import { useQuery } from '@tanstack/react-query'
import { ArrowLeft, User, Mail, Phone, MapPin } from 'lucide-react'
import { studentApi } from '../../services/api'

export default function StudentDetail() {
  const { id } = useParams()

  const { data: student, isLoading } = useQuery({
    queryKey: ['student', id],
    queryFn: () => studentApi.getById(id).then(res => res.data),
  })

  const { data: paymentManager } = useQuery({
    queryKey: ['paymentManager', id],
    queryFn: () => studentApi.getPaymentManager(id).then(res => res.data),
    enabled: !!id,
  })

  if (isLoading) {
    return <div className="p-8 text-center text-gray-500">Loading...</div>
  }

  if (!student) {
    return <div className="p-8 text-center text-gray-500">Student not found</div>
  }

  const profile = student.generalUserProfile

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center space-x-4">
        <Link to="/students" className="p-2 hover:bg-gray-100 rounded-lg">
          <ArrowLeft className="w-5 h-5" />
        </Link>
        <div>
          <h1 className="text-2xl font-bold text-gray-900">
            {student.profileName || student.nameOnCertificate}
          </h1>
          <p className="text-gray-500">Student ID: {student.studentId}</p>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Profile Card */}
        <div className="card">
          <div className="card-body text-center">
            <div className="w-24 h-24 bg-gray-200 rounded-full flex items-center justify-center mx-auto mb-4">
              <User className="w-12 h-12 text-gray-400" />
            </div>
            <h2 className="text-xl font-semibold text-gray-900">
              {student.profileName || student.nameOnCertificate}
            </h2>
            <p className="text-gray-500">{student.studentId}</p>
            
            <div className="mt-6 space-y-3 text-left">
              {profile?.email && (
                <div className="flex items-center space-x-3 text-sm">
                  <Mail className="w-4 h-4 text-gray-400" />
                  <span>{profile.email}</span>
                </div>
              )}
              {profile?.contactNo && (
                <div className="flex items-center space-x-3 text-sm">
                  <Phone className="w-4 h-4 text-gray-400" />
                  <span>{profile.contactNo}</span>
                </div>
              )}
              {profile?.address && (
                <div className="flex items-center space-x-3 text-sm">
                  <MapPin className="w-4 h-4 text-gray-400" />
                  <span>{profile.address}</span>
                </div>
              )}
            </div>
          </div>
        </div>

        {/* Academic Info */}
        <div className="lg:col-span-2 space-y-6">
          <div className="card">
            <div className="card-header">
              <h2 className="text-lg font-semibold">Academic Information</h2>
            </div>
            <div className="card-body">
              <dl className="grid grid-cols-2 gap-4">
                <div>
                  <dt className="text-sm text-gray-500">Course</dt>
                  <dd className="font-medium">{student.course?.courseTitle || '-'}</dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Academic Year</dt>
                  <dd className="font-medium">{student.academicYear || '-'}</dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">SCN Number</dt>
                  <dd className="font-medium">{student.scnNo || '-'}</dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">UK Award ID</dt>
                  <dd className="font-medium">{student.ukAwardId || '-'}</dd>
                </div>
              </dl>
            </div>
          </div>

          {/* Payment Info */}
          <div className="card">
            <div className="card-header">
              <h2 className="text-lg font-semibold">Payment Information</h2>
            </div>
            <div className="card-body">
              <dl className="grid grid-cols-2 gap-4">
                <div>
                  <dt className="text-sm text-gray-500">Payment Option</dt>
                  <dd className="font-medium">
                    {paymentManager?.paymentOption?.name || '-'}
                  </dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Scholarship</dt>
                  <dd className="font-medium">{paymentManager?.scholarship || 0}%</dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Payable Amount</dt>
                  <dd className="font-medium">
                    Rs. {(paymentManager?.payableAmount || 0).toLocaleString()}
                  </dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Paid Amount</dt>
                  <dd className="font-medium">
                    Rs. {(paymentManager?.paidAmount || 0).toLocaleString()}
                  </dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Total Due</dt>
                  <dd className="font-medium text-danger-500">
                    Rs. {(paymentManager?.totalDue || 0).toLocaleString()}
                  </dd>
                </div>
                <div>
                  <dt className="text-sm text-gray-500">Portal Paid</dt>
                  <dd className="font-medium">
                    {paymentManager?.isPortalPaid ? 'Yes' : 'No'}
                  </dd>
                </div>
              </dl>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
