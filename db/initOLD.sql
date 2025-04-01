-- Enable the uuid-ossp extension for UUID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE cvs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    version_name TEXT UNIQUE
);

CREATE TABLE cover_letters (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT UNIQUE,
    letter_en TEXT,
    letter_fi TEXT
);

CREATE TABLE companies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_slug TEXT UNIQUE,
    cv_id UUID REFERENCES cvs(id) ON DELETE SET NULL,
    cover_letter_id UUID REFERENCES cover_letters(id) ON DELETE SET NULL
);

CREATE TABLE notepads (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    company_id UUID REFERENCES companies(id) ON DELETE SET NULL,
    order_version INT DEFAULT 0 -- Initialize version for optimistic locking
);

CREATE TABLE todos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    notepad_id UUID REFERENCES notepads(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    is_completed BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE todo_orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    notepad_id UUID REFERENCES notepads(id) ON DELETE CASCADE,
    todo_id UUID REFERENCES todos(id) ON DELETE CASCADE,
    order_index INT NOT NULL
);

-- Table for CV components/sections
CREATE TABLE cv_components (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    cv_id UUID REFERENCES cvs(id) ON DELETE CASCADE,
    category TEXT, -- ie. contact-info, name, degree, title, entry_name, entry_text
    text_en TEXT,
    text_fi TEXT
);

-- Create a new junction table for the many-to-many relationship
CREATE TABLE cv_component_mappings (
    cv_id UUID REFERENCES cvs(id) ON DELETE CASCADE,
    component_id UUID REFERENCES cv_components(id) ON DELETE CASCADE,
    display_order INT,
    PRIMARY KEY (cv_id, component_id) -- One component can only be once in a CV
);

-- Indexing for performance
CREATE INDEX idx_todo_orders_notepad_id ON todo_orders(notepad_id);
CREATE INDEX idx_todos_notepad_id ON todos(notepad_id);
CREATE INDEX idx_notepads_company_id ON notepads(company_id);CREATE INDEX idx_cv_components_cv_id ON cv_components(cv_id);
