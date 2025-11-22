import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../api/axios';

const Booking: React.FC = () => {
    const [departments, setDepartments] = useState<any[]>([]);
    const [doctors, setDoctors] = useState<any[]>([]);
    const [selectedDept, setSelectedDept] = useState('');
    const [selectedDoctor, setSelectedDoctor] = useState('');
    const [date, setDate] = useState('');
    const [time, setTime] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        api.get('/departments').then(res => setDepartments(res.data));
        api.get('/doctors').then(res => setDoctors(res.data));
    }, []);

    const filteredDoctors = selectedDept
        ? doctors.filter(d => d.department_id === parseInt(selectedDept))
        : doctors;

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const scheduledAt = new Date(`${date}T${time}`).toISOString();
            await api.post('/appointments', {
                doctor_id: selectedDoctor,
                department_id: selectedDept,
                scheduled_at: scheduledAt
            });
            navigate('/dashboard');
        } catch (error) {
            alert('Failed to book appointment');
        }
    };

    return (
        <div className="booking-container">
            <h2>Book Appointment</h2>
            <form onSubmit={handleSubmit}>
                <div>
                    <label>Department:</label>
                    <select value={selectedDept} onChange={e => setSelectedDept(e.target.value)} required>
                        <option value="">Select Department</option>
                        {departments.map(d => (
                            <option key={d.id} value={d.id}>{d.name}</option>
                        ))}
                    </select>
                </div>

                <div>
                    <label>Doctor:</label>
                    <select value={selectedDoctor} onChange={e => setSelectedDoctor(e.target.value)} required>
                        <option value="">Select Doctor</option>
                        {filteredDoctors.map(d => (
                            <option key={d.id} value={d.id}>Dr. {d.first_name} {d.last_name}</option>
                        ))}
                    </select>
                </div>

                <div>
                    <label>Date:</label>
                    <input type="date" value={date} onChange={e => setDate(e.target.value)} required />
                </div>

                <div>
                    <label>Time:</label>
                    <input type="time" value={time} onChange={e => setTime(e.target.value)} required />
                </div>

                <button type="submit">Book Now</button>
            </form>
        </div>
    );
};

export default Booking;
