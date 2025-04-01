
import { Component, Input, Output, EventEmitter, OnInit } from '@angular/core';
import { CurrencyPipe, UpperCasePipe } from '@angular/common';
import { CustomTrimPipe } from '../pipes/custom-trim.pipe';
import { CartService } from '../services/cart.service';
import { Router } from '@angular/router';
import { AuthService } from '../auth.service';

@Component({
  selector: 'app-product-item',
  standalone: true,
  imports: [CurrencyPipe, UpperCasePipe, CustomTrimPipe],
  templateUrl: './product-item.component.html',
  styleUrls: ['./product-item.component.css']
})
export class ProductItemComponent implements OnInit {
  @Input() product: any;
  @Output() productSelected = new EventEmitter<number>();

  constructor(
    private cartService: CartService,
    private router: Router,
    private authService: AuthService 
  ) {}

  ngOnInit(): void {
    console.log('Received Product in ProductItemComponent:', this.product);
  }

  selectProduct(id: number | undefined): void {
    if (id) {
      this.productSelected.emit(id);
    }
  }

  
  addToCart(): void {
    if (this.product) {
      this.cartService.addToCart(this.product);
      alert(`${this.product.title} added to cart!`);
    }
  }

  logout(): void {
    this.authService.logout(); 
    this.router.navigate(['/login']); 
  }

  goToCart(): void {
    this.router.navigate(['/cart']);
  }
}

