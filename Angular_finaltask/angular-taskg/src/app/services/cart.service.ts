import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CartService {
  private cart: any[] = [];
  private cartSubject = new BehaviorSubject<any[]>([]);

  constructor() {
    this.loadCart();
  }

  private loadCart() {
    this.cart = JSON.parse(localStorage.getItem('cart') || '[]');
    this.cartSubject.next(this.cart);
  }

  private saveCart() {
    localStorage.setItem('cart', JSON.stringify(this.cart));
    this.cartSubject.next(this.cart);
  }

  addToCart(product: any) {
    this.cart.push(product);
    this.saveCart();
  }

  getCart() {
    return this.cartSubject.asObservable();
  }

  setCart(updatedCart: any[]) {  
    this.cart = updatedCart;
    this.saveCart();
  }

  clearCart() {
    this.cart = [];
    this.saveCart();
  }
}
