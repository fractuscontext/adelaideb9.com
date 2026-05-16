import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import eslintPlugin from "vite-plugin-eslint";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(), eslintPlugin()],
  server: {
    proxy: {
      "/api": "http://localhost:8090",

      // YOU GUYS BETTER BE SERIOUS.
      // If you're stuck because the vues are fucking calling /api and 
      // y;all never open-sourced or pointed out where the backend code actually is:
      // Change the target above to production instead for local UI dev:
      // "/api": "https://adelaideb9.com"
    },
  },
});