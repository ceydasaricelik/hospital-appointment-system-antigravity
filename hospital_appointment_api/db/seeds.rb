# Clear existing data
Appointment.destroy_all
Doctor.destroy_all
Patient.destroy_all
Department.destroy_all
User.destroy_all

# Create Departments
cardiology = Department.create!(name: 'Cardiology', description: 'Heart related issues')
neurology = Department.create!(name: 'Neurology', description: 'Brain related issues')

# Create Users & Doctors
doc_user1 = User.create!(email: 'doctor1@example.com', password: 'password123', role: 'doctor')
Doctor.create!(user: doc_user1, department: cardiology, first_name: 'Gregory', last_name: 'House', specialization: 'Diagnostician')

doc_user2 = User.create!(email: 'doctor2@example.com', password: 'password123', role: 'doctor')
Doctor.create!(user: doc_user2, department: neurology, first_name: 'Derek', last_name: 'Shepherd', specialization: 'Neurosurgeon')

# Create User & Patient
patient_user = User.create!(email: 'patient@example.com', password: 'password123', role: 'patient')
patient = Patient.create!(user: patient_user, first_name: 'John', last_name: 'Doe', date_of_birth: '1985-05-20')

puts "Seeded #{User.count} users, #{Department.count} departments."
