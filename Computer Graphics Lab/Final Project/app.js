import * as THREE from 'three';
import { OrbitControls } from 'OrbitControls';

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

// OrbitControls for better navigation
const controls = new OrbitControls(camera, renderer.domElement);

// Positioning the camera
camera.position.set(0, 5, 10);
controls.update();

// Castle walls
const wallGeometry = new THREE.BoxGeometry(10, 5, 1);
const wallMaterial = new THREE.MeshBasicMaterial({ color: 0x8B4513 });
const wall = new THREE.Mesh(wallGeometry, wallMaterial);
wall.position.set(0, 2.5, 0);
scene.add(wall);

// Drawbridge
const drawbridgeGeometry = new THREE.BoxGeometry(3, 0.1, 5);
const drawbridgeMaterial = new THREE.MeshBasicMaterial({ color: 0x8B4513 });
const drawbridge = new THREE.Mesh(drawbridgeGeometry, drawbridgeMaterial);
drawbridge.position.set(0, 0.05, 2.5);
scene.add(drawbridge);

// Keyboard interaction for camera movement
document.addEventListener('keydown', (event) => {
    const key = event.key;
    const speed = 0.2;
    if (key === 'w') {
        camera.position.z -= speed;
    } else if (key === 's') {
        camera.position.z += speed;
    } else if (key === 'a') {
        camera.position.x -= speed;
    } else if (key === 'd') {
        camera.position.x += speed;
    }
    controls.update();
});

// Mouse interaction for raising and lowering the drawbridge
document.addEventListener('mousedown', () => {
    if (drawbridge.rotation.x <= 0) {
        drawbridge.rotation.x += Math.PI / 4;
    } else {
        drawbridge.rotation.x = 0;
    }
});

// Sky color animation to simulate different times of the day
let time = 0;
const animate = () => {
    requestAnimationFrame(animate);

    // Update sky color
    time += 0.01;
    const color = new THREE.Color(`hsl(${(time * 20) % 360}, 100%, 50%)`);
    renderer.setClearColor(color, 1);

    controls.update();
    renderer.render(scene, camera);
};

animate();
