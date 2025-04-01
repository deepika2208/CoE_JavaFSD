import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private isAuthenticated = false;

  constructor(private router: Router) {}

  login(username: string, password: string): boolean {
    if (username === 'dp' && password === '123') {
      this.isAuthenticated = true;
      localStorage.setItem('isAuthenticated', 'true');
      return true;
    }
    return false;
  }

  logout(): void {
    this.isAuthenticated = false;
    localStorage.removeItem('isAuthenticated');
  }

  isLoggedIn(): boolean {
    const storedAuth = localStorage.getItem('isAuthenticated');
    return storedAuth === 'true';
  }

  redirectToFeedback(): void {
    this.router.navigate(['/feedback']);
  }
}
