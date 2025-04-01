import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

interface Product {
  id: number;
  title: string;  
  price: number;
  description: string;
  image: string;
}

@Injectable({
  providedIn: 'root',
})
export class ProductService {
  private apiUrl = 'https://fakestoreapi.com/products';
  private feedbackUrl = 'http://localhost:4500/feedback';


  constructor(private http: HttpClient) {}

  getProducts(): Observable<Product[]> {
    return this.http.get<Product[]>(this.apiUrl);
  }

  getProductById(id: number): Observable<Product> {
    return this.http.get<Product>(`${this.apiUrl}/${id}`);
  }
  submitFeedback(feedback: { name: string; email: string; message: string }): Observable<any> {
    return this.http.post<any>(this.feedbackUrl, feedback);
  }

  
  getFeedback(): Observable<any[]> {
    return this.http.get<any[]>(this.feedbackUrl);
  }
}

