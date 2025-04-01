import { Component, OnInit } from '@angular/core';
import { ProductService } from '../product.service';
import { Router } from '@angular/router';
import { ProductItemComponent } from '../product-item/product-item.component';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-product-list',
  standalone: true,
  imports: [ProductItemComponent, CommonModule, RouterModule, ReactiveFormsModule],
  templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {
  products: any[] = [];
  showModal = false;
  feedbackForm: FormGroup;
  feedbackList: any[] = []; 

  constructor(
    private productService: ProductService, 
    private router: Router,
    private fb: FormBuilder
  ) {
    this.feedbackForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(3)]],
      email: ['', [Validators.required, Validators.email]],
      message: ['', [Validators.required, Validators.minLength(10)]]
    });
  }

  ngOnInit(): void {
    this.productService.getProducts().subscribe({
      next: (data: any[]) => {
        console.log('Fetched Products:', data);  
        this.products = data;
      },
      error: (err: any) => console.error('Error fetching products:', err)
    });

    
    this.getFeedbackList();
  }

  onProductSelected(productId: number): void {
    this.router.navigate(['/product', productId]);
  }

  openModal(): void {
    this.showModal = true;
  }

  closeModal(): void {
    this.showModal = false;
    this.feedbackForm.reset();
  }

  submitFeedback(): void {
    if (this.feedbackForm.valid) {
      const feedbackData = this.feedbackForm.value;

      
      this.feedbackList.push(feedbackData);

      
      this.productService.submitFeedback(feedbackData).subscribe({
        next: (response: any) => {
          console.log('Feedback Submitted:', response);
          alert('Thank you for your feedback!');
          this.getFeedbackList(); 
          this.closeModal();
        },
        error: (err: any) => console.error('Error submitting feedback:', err)
      });
    }
  }

  
  getFeedbackList(): void {
    this.productService.getFeedback().subscribe({
      next: (data: any[]) => {
        console.log('Fetched Feedback:', data);
        this.feedbackList = data;
      },
      error: (err: any) => console.error('Error fetching feedback:', err)
    });
  }
}