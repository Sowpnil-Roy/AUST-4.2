import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';

let scene, camera, renderer, controls;
let sky, sun, moon;
let sunLight, moonLight;
let dayTime = 0;
let ground;
let cameraRadius = 150; 
let cameraAngle = 0; 

function init() {
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    renderer = new THREE.WebGLRenderer({ antialias: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    document.body.appendChild(renderer.domElement);

    // Set the initial camera position
    camera.position.set(cameraRadius * Math.cos(cameraAngle), 100, cameraRadius * Math.sin(cameraAngle));

    // Initialize OrbitControls to enable camera movement
    controls = new OrbitControls(camera, renderer.domElement);
    controls.target.set(0, 20, 0);
    controls.update();

    createLights();
    createSky();
    createSunAndMoon();
    createGround();
    createRiver();
    createCastle();
    createSurroundingWall();
    createDrawbridge();
    createCastleDoor();
    createTrees();
}


function createLights() {
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.3);
    scene.add(ambientLight);

    sunLight = new THREE.DirectionalLight(0xffffaa, 1);
    moonLight = new THREE.DirectionalLight(0x4444ff, 0.5);
    scene.add(sunLight, moonLight);
}


function createSky() {
    const skyGeometry = new THREE.SphereGeometry(500, 32, 32);
    const skyMaterial = new THREE.MeshBasicMaterial({ side: THREE.BackSide });
    sky = new THREE.Mesh(skyGeometry, skyMaterial);
    scene.add(sky);
}

function createSunAndMoon() {
    const sunGeometry = new THREE.SphereGeometry(10, 32, 32);
    const sunMaterial = new THREE.MeshBasicMaterial({ color: 0xffff00 });
    sun = new THREE.Mesh(sunGeometry, sunMaterial);
    scene.add(sun);

    const moonGeometry = new THREE.SphereGeometry(5, 32, 32);
    const moonMaterial = new THREE.MeshBasicMaterial({ color: 0xcccccc });
    moon = new THREE.Mesh(moonGeometry, moonMaterial);
    scene.add(moon);
}

function createGround() {
    const groundSize = 500;
    const groundGeometry = new THREE.PlaneGeometry(groundSize, groundSize);
    const groundMaterial = new THREE.MeshStandardMaterial({ color: 0x3a9d23 });
    ground = new THREE.Mesh(groundGeometry, groundMaterial);
    ground.rotation.x = -Math.PI / 2;
    ground.position.y = -0.1;
    scene.add(ground);
}

function createRiver() {
    const riverWidth = 20;
    const riverDepth = 5;
    const innerSize = 120;
    const outerSize = innerSize + riverWidth * 2;

    const riverShape = new THREE.Shape();
    riverShape.moveTo(-outerSize/2, -outerSize/2);
    riverShape.lineTo(outerSize/2, -outerSize/2);
    riverShape.lineTo(outerSize/2, outerSize/2);
    riverShape.lineTo(-outerSize/2, outerSize/2);
    riverShape.lineTo(-outerSize/2, -outerSize/2);

    const holeShape = new THREE.Shape();
    holeShape.moveTo(-innerSize/2, -innerSize/2);
    holeShape.lineTo(innerSize/2, -innerSize/2);
    holeShape.lineTo(innerSize/2, innerSize/2);
    holeShape.lineTo(-innerSize/2, innerSize/2);
    holeShape.lineTo(-innerSize/2, -innerSize/2);

    riverShape.holes.push(holeShape);

    const riverGeometry = new THREE.ExtrudeGeometry(riverShape, {
        depth: riverDepth,
        bevelEnabled: false
    });

    const riverMaterial = new THREE.MeshStandardMaterial({ color: 0x4444ff });
    const river = new THREE.Mesh(riverGeometry, riverMaterial);
    river.rotation.x = -Math.PI / 2;
    river.position.y = -riverDepth + 0.1;

    scene.add(river);
}

function createCastle() {
    const wallMaterial = new THREE.MeshStandardMaterial({ color: 0xe6d0b3 });
    
    // Main rectangular structure
    createWall(60, 20, 40, 0, 10, 0);
    
    // Left wing
    createWall(30, 20, 40, -45, 10, 0);
    
    // Right wing
    createWall(30, 20, 40, 45, 10, 0);
    
    // Front wall
    createWall(90, 20, 5, 0, 10, 42.5);
    
    // Circular tower
    createTower(-45, 10, 42.5);
    
    // Courtyard
    createCourtyard();
}

function createWall(width, height, depth, x, y, z) {
    const wallGeometry = new THREE.BoxGeometry(width, height, depth);
    const wallMaterial = new THREE.MeshStandardMaterial({ color: 0xe6d0b3 });
    const wall = new THREE.Mesh(wallGeometry, wallMaterial);
    wall.position.set(x, y, z);
    scene.add(wall);
    addCrenellations(wall, width, depth);
}

function createTower(x, y, z) {
    const towerGeometry = new THREE.CylinderGeometry(10, 10, 25, 32);
    const towerMaterial = new THREE.MeshStandardMaterial({ color: 0xe6d0b3 });
    const tower = new THREE.Mesh(towerGeometry, towerMaterial);
    tower.position.set(x, y + 2.5, z);
    scene.add(tower);
    addCrenellations(tower, 20, 20, true);
}

function createCourtyard() {
    const courtyardGeometry = new THREE.PlaneGeometry(80, 80);
    const courtyardMaterial = new THREE.MeshStandardMaterial({ color: 0x91b496 });
    const courtyard = new THREE.Mesh(courtyardGeometry, courtyardMaterial);
    courtyard.rotation.x = -Math.PI / 2;
    courtyard.position.y = 0.1;
    scene.add(courtyard);
}

function createSurroundingWall() {
    const wallMaterial = new THREE.MeshStandardMaterial({ color: 0xe6d0b3 });
    
    const wallSize = 110;
    
    // Front wall
    createWall(wallSize, 15, 5, 0, 7.5, wallSize / 2);
    
    // Back wall
    createWall(wallSize, 15, 5, 0, 7.5, -wallSize / 2);
    
    // Left wall
    createWall(5, 15, wallSize, -wallSize / 2, 7.5, 0);
    
    // Right wall
    createWall(5, 15, wallSize, wallSize / 2, 7.5, 0);
}

let drawbridge;  // Declare the drawbridge variable

function createDrawbridge() {
    const bridgeGeometry = new THREE.BoxGeometry(20, 2, 30);
    const bridgeMaterial = new THREE.MeshStandardMaterial({ color: 0x8b4513 });
    drawbridge = new THREE.Mesh(bridgeGeometry, bridgeMaterial);
    drawbridge.position.set(0, 1, 65);
    drawbridge.rotation.x = 0;  // Start with the drawbridge lowered
    scene.add(drawbridge);

    // Drawbridge towers
    createWall(10, 20, 10, -15, 10, 50);
    createWall(10, 20, 10, 15, 10, 50);
}

let bridgeRaised = false;
let bridgeRotationSpeed = 0.01; 

function updateDrawbridge() {
    if (bridgeRaised && drawbridge.rotation.x > -Math.PI / 2) {
        drawbridge.rotation.x -= bridgeRotationSpeed;  // Raise the drawbridge
    } else if (!bridgeRaised && drawbridge.rotation.x < 0) {
        drawbridge.rotation.x += bridgeRotationSpeed;  // Lower the drawbridge
    }
}

window.addEventListener('keydown', (event) => {
    if (event.key === 'b') {
        bridgeRaised = !bridgeRaised;  // Toggle drawbridge position on pressing 'b'
    }
});


function createCastleDoor() {
    const doorWidth = 15;
    const doorHeight = 12;
    const doorDepth = 2;

    const doorGeometry = new THREE.BoxGeometry(doorWidth, doorHeight, doorDepth);
    const doorMaterial = new THREE.MeshStandardMaterial({ color: 0x8b4513 });
    const door = new THREE.Mesh(doorGeometry, doorMaterial);
    door.position.set(0, doorHeight / 2, 55); // Moved forward to be just in front of the drawbridge
    scene.add(door);

    // Add door frame
    const frameWidth = 1;
    const frameGeometry = new THREE.BoxGeometry(doorWidth + frameWidth * 2, doorHeight + frameWidth, doorDepth + 1);
    const frameMaterial = new THREE.MeshStandardMaterial({ color: 0x5c3a21 });
    const frame = new THREE.Mesh(frameGeometry, frameMaterial);
    frame.position.set(0, doorHeight / 2, 55.5); // Adjusted to match the new door position
    scene.add(frame);

    // Add door handle
    const handleGeometry = new THREE.CylinderGeometry(0.5, 0.5, 3, 8);
    const handleMaterial = new THREE.MeshStandardMaterial({ color: 0xd4af37 });
    const handle = new THREE.Mesh(handleGeometry, handleMaterial);
    handle.rotation.z = Math.PI / 2;
    handle.position.set(5, doorHeight / 2, 56); // Adjusted to match the new door position
    scene.add(handle);
}

function createTrees() {
    const treePositions = [
        [-150, 0, -150],
        [150, 0, -150],
        [-150, 0, 150],
        [150, 0, 150],
        [0, 0, -180],
        [-100, 0, -180],
        [100, 0, -180],
        [0, 0, 180],
        [-100, 0, 180],
        [100, 0, 180],
        [-180, 0, 0],
        [-180, 0, -100],
        [-180, 0, 100],
        [180, 0, 0],
        [180, 0, -100],
        [180, 0, 100]
    ];

    treePositions.forEach(position => {
        createTree(...position);
    });
}



function createTree(x, y, z) {
    const trunkGeometry = new THREE.CylinderGeometry(1, 1, 10, 8);
    const trunkMaterial = new THREE.MeshStandardMaterial({ color: 0x8b4513 });
    const trunk = new THREE.Mesh(trunkGeometry, trunkMaterial);
    trunk.position.set(x, y + 5, z);

    const leavesGeometry = new THREE.ConeGeometry(5, 15, 8);
    const leavesMaterial = new THREE.MeshStandardMaterial({ color: 0x228b22 });
    const leaves = new THREE.Mesh(leavesGeometry, leavesMaterial);
    leaves.position.set(0, 10, 0);

    trunk.add(leaves);
    scene.add(trunk);
}

function addCrenellations(parent, width, depth, isCircular = false) {
    const crenellationGeometry = new THREE.BoxGeometry(2, 2, 2);
    const crenellationMaterial = new THREE.MeshStandardMaterial({ color: 0xc19a6b });

    const count = isCircular ? 16 : Math.floor(width / 4);
    for (let i = 0; i < count; i++) {
        const crenellation = new THREE.Mesh(crenellationGeometry, crenellationMaterial);
        if (isCircular) {
            const angle = (i / count) * Math.PI * 2;
            crenellation.position.set(
                Math.cos(angle) * (width / 2),
                parent.geometry.parameters.height / 2 + 1,
                Math.sin(angle) * (depth / 2)
            );
        } else {
            crenellation.position.set(
                (i - count / 2) * 4 + 2,
                parent.geometry.parameters.height / 2 + 1,
                depth / 2
            );
        }
        parent.add(crenellation);
    }
}

function updateDayNightCycle() {
    dayTime += 0.001;
    if (dayTime > 1) dayTime -= 1;

    const duskColor = new THREE.Color(0x041A40);

    // Update sky color
    const skyColor = new THREE.Color();
    if (dayTime < 0.25 || dayTime > 0.75) {
        // Night
        skyColor.set(duskColor);
    } else {
        // Day (dusk color)
        skyColor.setRGB(0.5, 0.25, 0.1); 
    }
    sky.material.color = skyColor;

    // Update sun and moon positions
    const angle = dayTime * Math.PI * 2;
    sun.position.set(
        Math.cos(angle) * 400,
        Math.sin(angle) * 400,
        0
    );
    moon.position.set(
        Math.cos(angle + Math.PI) * 400,
        Math.sin(angle + Math.PI) * 400,
        0
    );

    const lightIntensity = Math.sin(dayTime * Math.PI) * 0.5 + 0.5;
    sunLight.intensity = lightIntensity;
    moonLight.intensity = 0.5 - lightIntensity * 0.3;
}


function animate() {
    requestAnimationFrame(animate);
    updateDayNightCycle();
    updateDrawbridge(); 

    cameraAngle += 0.001; 
    camera.position.set(cameraRadius * Math.cos(cameraAngle), 100, cameraRadius * Math.sin(cameraAngle));
    camera.lookAt(0, 20, 0); 

    controls.update();
    renderer.render(scene, camera);
}


init();
animate();

