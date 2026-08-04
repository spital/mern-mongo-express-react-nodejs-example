import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  // Keep the existing Docker/README REACT_APP_* variables working while
  // allowing the standard Vite VITE_* names for new deployments.
  envPrefix: ["VITE_", "REACT_APP_"],
  server: {
    host: true,
    port: 3000,
    strictPort: true,
    proxy: {
      "/api": "http://localhost:3001"
    }
  }
});
