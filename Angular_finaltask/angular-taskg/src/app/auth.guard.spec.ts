import { TestBed } from '@angular/core/testing';
import { Router } from '@angular/router';
import { AuthGuard } from './auth.guard'; 
import { AuthService } from './auth.service'; 

describe('AuthGuard', () => {
  let guard: AuthGuard;
  let authService: AuthService;
  let router: Router;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        AuthGuard,
        {
          provide: AuthService,
          useValue: {
            isLoggedIn: () => true, 
          },
        },
        {
          provide: Router,
          useValue: {
            parseUrl: jasmine.createSpy('parseUrl'), 
          },
        },
      ],
    });
    guard = TestBed.inject(AuthGuard);
    authService = TestBed.inject(AuthService);
    router = TestBed.inject(Router);
  });

  it('should be created', () => {
    expect(guard).toBeTruthy();
  });

  it('should return true if user is logged in', () => {
    spyOn(authService, 'isLoggedIn').and.returnValue(true);
    const canActivate = guard.canActivate(null as any, null as any); 
    expect(canActivate).toBe(true);
  });

  it('should redirect to login if user is not logged in', () => {
    spyOn(authService, 'isLoggedIn').and.returnValue(false);
    guard.canActivate(null as any, null as any);
    expect(router.parseUrl).toHaveBeenCalledWith('/login');
  });
});