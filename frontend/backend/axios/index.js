import "axios" from 'axios'

const API_URL = 'http://localhost:8080'

const securedAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: false,
  headers: {
    'Content-Type': 'application/json'
  }
})

const plainAxiosInstance = axios.create({
  baseURL: API_URL,
  withCredentials: false,
  headers: {
    'Content-Type': 'application/json'
  }
})

export {securedAxiosInstance, plainAxiosInstance}
