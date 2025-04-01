import { Component, OnInit } from '@angular/core';
import { CartService } from '../services/cart.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-cart',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.css']
})
export class CartComponent implements OnInit {
  cartItems: any[] = [];

  constructor(private cartService: CartService) {}

  ngOnInit(): void {
    this.cartService.getCart().subscribe(items => {
      this.cartItems = [...items];
    });
  }

  removeFromCart(index: number) {
    this.cartItems.splice(index, 1);
    this.cartService.setCart(this.cartItems);
  }

  clearCart() {
    this.cartService.clearCart();
    this.cartItems = [];
  }
}
