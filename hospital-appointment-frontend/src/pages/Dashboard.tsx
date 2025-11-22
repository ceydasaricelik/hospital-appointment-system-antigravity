import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import api from '../api/axios';
import { useAuth } from '../context/AuthContext';

const Dashboard: React.FC = () => {
    const { user, logout } = useAuth();
    const [appointments, setAppointments] = useState<any[]>([]);

    useEffect(() => {
        const fetchAppointments = async () => {
            try {
                const response = await api.get('/appointments');
                setAppointments(response.data);
            } catch (error) {
                console.error('Error fetching appointments', error);
            }
        };

        fetchAppointments();
    }, []);

    return (
        <div className="dashboard-container">
            <header>
                <h1>Welcome, {user?.profile?.first_name}</h1>
                <button onClick={logout}>Logout</button>
            </header>

            <section>
                <h2>Your Appointments</h2>
                {appointments.length === 0 ? (
                    <p>No appointments found.</p>
                ) : (
                    <ul>
                        {appointments.map((apt) => (
                            <li key={apt.id}>
                                {new Date(apt.scheduled_at).toLocaleString()} - {apt.doctor.first_name} {apt.doctor.last_name} ({apt.department.name}) - {apt.status}
                            </li>
                        ))}
                    </ul>
                )}
                <Link to="/book">Book New Appointment</Link>
            </section>
        </div>
    );
};

export default Dashboard;
