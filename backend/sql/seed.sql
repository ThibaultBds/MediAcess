INSERT INTO roles (name, description) 
VALUES
('Administrateur', 'Accès total au système'),
('Superviseur', 'Gestion des utilisateurs et consultation des logs'),
('Technicien', 'Consultation des logs uniquement'),
('Personnel', 'Accès au tableau de bord personnel');

INSERT INTO permissions (name, description) 
VALUES
('users.read', 'Lire les utilisateurs'),
('users.write', 'Créer et modifier les utilisateurs'),
('users.delete', 'Supprimer les utilisateurs'),
('roles.read', 'Lire les rôles'),
('roles.write', 'Créer et modifier les rôles'),
('roles.delete', 'Supprimer les rôles'),
('permissions.manage', 'Gérer les permissions'),
('audit.read', 'Lire les journaux d''audit'),
('dashboard.read', 'Accéder au tableau de bord personnel');

-- Personnel 
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r 
JOIN permissions p ON p.name = 'dashboard.read'
WHERE r.name = 'Personnel';

-- Technicien
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r 
JOIN permissions p ON p.name IN ('audit.read', 'dashboard.read')
WHERE r.name = 'Technicien';

-- Superviseur 
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r 
JOIN permissions p ON p.name IN ('users.read', 'users.write', 'audit.read', 'dashboard.read')
WHERE r.name = 'Superviseur';

-- Administrateur 
INSERT INTO role_permissions (role_id, permission_id)
SELECT r.id, p.id
FROM roles r 
JOIN permissions p ON p.name IN (
    'users.read',
    'users.write',
    'users.delete',
    'roles.read',
    'roles.write',
    'roles.delete',
    'permissions.manage',
    'audit.read',
    'dashboard.read'
)
WHERE r.name = 'Administrateur';

INSERT INTO users (email, password, first_name, last_name, is_active) 
VALUES
('admin@mediaccess.local', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Alice', 'Admin', 1),
('superviseur@mediaccess.local', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Sofia', 'Superviseur', 1),
('technicien@mediaccess.local', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Thomas', 'Technicien', 1),
('personnel@mediaccess.local', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Nina', 'Personnel', 1);

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id
FROM users u
JOIN roles r ON r.name = 'Administrateur'
WHERE u.email = 'admin@mediaccess.local';

INSERT INTO user_roles (user_id,  role_id)
SELECT u.id, r.id
FROM users u 
JOIN roles r ON r.name = 'Superviseur'
WHERE u.email = 'superviseur@mediaccess.local';

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id
FROM users u
JOIN roles r ON r.name = 'Technicien'
WHERE u.email = 'technicien@mediaccess.local';

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id 
FROM users u
JOIN roles r ON r.name = 'Personnel'
WHERE u.email = 'personnel@mediaccess.local' 

