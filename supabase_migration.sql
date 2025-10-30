-- Silvan App Database Schema
-- This migration creates all necessary tables for the event management app

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users/Players Table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Events Table
CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    location TEXT NOT NULL,
    event_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_archived BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Utensils Table
CREATE TABLE utensils (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    icon TEXT NOT NULL,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Event Responses Table (Zusagen/Absagen)
CREATE TABLE event_responses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    event_id UUID REFERENCES events(id) ON DELETE CASCADE,
    status TEXT CHECK (status IN ('yes', 'no', 'maybe')),
    guests INTEGER DEFAULT 0,
    comment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, event_id)
);

-- Response Utensils (Many-to-Many)
CREATE TABLE response_utensils (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    response_id UUID REFERENCES event_responses(id) ON DELETE CASCADE,
    utensil_id UUID REFERENCES utensils(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(response_id, utensil_id)
);

-- Indexes for better query performance
CREATE INDEX idx_event_responses_user_id ON event_responses(user_id);
CREATE INDEX idx_event_responses_event_id ON event_responses(event_id);
CREATE INDEX idx_events_date ON events(event_date);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_active ON users(is_active);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_event_responses_updated_at BEFORE UPDATE ON event_responses
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Insert default utensils
INSERT INTO utensils (name, icon, display_order) VALUES
    ('Ball', '⚽', 1),
    ('Pumpe', '🔧', 2),
    ('Schlüssel', '🔑', 3);

-- Insert sample users (you should change passwords in production!)
INSERT INTO users (email, name, is_admin, is_active) VALUES
    ('admin@silvanapp.com', 'Admin User', TRUE, TRUE),
    ('wirchi@silvanapp.com', 'Wirchi', FALSE, TRUE),
    ('samuel@silvanapp.com', 'Samuel', FALSE, TRUE),
    ('phoenix@silvanapp.com', 'Phönix', FALSE, TRUE),
    ('andrea@silvanapp.com', 'Andrea', FALSE, TRUE),
    ('casanova@silvanapp.com', 'Casanova', FALSE, TRUE),
    ('cesar@silvanapp.com', 'Cesar', FALSE, TRUE),
    ('fabri@silvanapp.com', 'Fabri', FALSE, TRUE);

-- Insert sample events
INSERT INTO events (title, location, event_date, start_time, end_time) VALUES
    ('KTV AM Fussball', 'Fussballfeld', '2025-11-08', '19:30', '21:30'),
    ('KTV AM Running', 'Sportplatz', '2025-11-13', '18:00', '20:00'),
    ('KTV AM Basketball', 'Sporthalle', '2025-11-20', '19:00', '21:00');

-- Enable Row Level Security (RLS)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE utensils ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE response_utensils ENABLE ROW LEVEL SECURITY;

-- RLS Policies

-- Users: Everyone can read, only admins can modify
CREATE POLICY "Users are viewable by everyone" ON users
    FOR SELECT USING (true);

CREATE POLICY "Users can be updated by admins" ON users
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND is_admin = true
        )
    );

-- Events: Everyone can read, only admins can create/modify
CREATE POLICY "Events are viewable by everyone" ON events
    FOR SELECT USING (true);

CREATE POLICY "Events can be created by admins" ON events
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND is_admin = true
        )
    );

CREATE POLICY "Events can be updated by admins" ON events
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND is_admin = true
        )
    );

-- Utensils: Everyone can read, only admins can modify
CREATE POLICY "Utensils are viewable by everyone" ON utensils
    FOR SELECT USING (true);

CREATE POLICY "Utensils can be modified by admins" ON utensils
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE id = auth.uid() AND is_admin = true
        )
    );

-- Event Responses: Users can read all, but only create/update their own
CREATE POLICY "Event responses are viewable by everyone" ON event_responses
    FOR SELECT USING (true);

CREATE POLICY "Users can create their own responses" ON event_responses
    FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own responses" ON event_responses
    FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own responses" ON event_responses
    FOR DELETE USING (auth.uid() = user_id);

-- Response Utensils: Follow the same rules as responses
CREATE POLICY "Response utensils are viewable by everyone" ON response_utensils
    FOR SELECT USING (true);

CREATE POLICY "Users can manage utensils for their responses" ON response_utensils
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM event_responses 
            WHERE id = response_id AND user_id = auth.uid()
        )
    );

COMMENT ON TABLE users IS 'Stores user/player information';
COMMENT ON TABLE events IS 'Stores sport events';
COMMENT ON TABLE utensils IS 'Stores available utensils that can be brought to events';
COMMENT ON TABLE event_responses IS 'Stores user responses (yes/no/maybe) for events';
COMMENT ON TABLE response_utensils IS 'Links responses with utensils users bring';
