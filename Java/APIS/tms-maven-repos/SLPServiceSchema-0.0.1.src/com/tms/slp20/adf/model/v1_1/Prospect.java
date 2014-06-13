/*     */ package com.tms.slp20.adf.model.v1_1;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.List;
/*     */ import javax.xml.bind.annotation.XmlAccessType;
/*     */ import javax.xml.bind.annotation.XmlAccessorType;
/*     */ import javax.xml.bind.annotation.XmlAttribute;
/*     */ import javax.xml.bind.annotation.XmlElement;
/*     */ import javax.xml.bind.annotation.XmlRootElement;
/*     */ import javax.xml.bind.annotation.XmlType;
/*     */ import javax.xml.bind.annotation.adapters.CollapsedStringAdapter;
/*     */ import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
/*     */ 
/*     */ @XmlAccessorType(XmlAccessType.FIELD)
/*     */ @XmlType(name="", propOrder={"id", "requestdate", "vehicle", "customer", "vendor", "provider"})
/*     */ @XmlRootElement(name="prospect")
/*     */ public class Prospect
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String status;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected List<Id> id;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected String requestdate;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected List<Vehicle> vehicle;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected Customer customer;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected Vendor vendor;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected Provider provider;
/*     */ 
/*     */   public void setId(List<Id> id)
/*     */   {
/*  31 */     this.id = id;
/*     */   }
/*     */ 
/*     */   public void setVehicle(List<Vehicle> vehicle) {
/*  35 */     this.vehicle = vehicle;
/*     */   }
/*     */ 
/*     */   public String getStatus()
/*     */   {
/*  63 */     if (this.status == null) {
/*  64 */       return "new";
/*     */     }
/*  66 */     return this.status;
/*     */   }
/*     */ 
/*     */   public void setStatus(String value)
/*     */   {
/*  79 */     this.status = value;
/*     */   }
/*     */ 
/*     */   public List<Id> getId()
/*     */   {
/* 105 */     if (this.id == null) {
/* 106 */       this.id = new ArrayList();
/*     */     }
/* 108 */     return this.id;
/*     */   }
/*     */ 
/*     */   public String getRequestdate()
/*     */   {
/* 120 */     return this.requestdate;
/*     */   }
/*     */ 
/*     */   public void setRequestdate(String value)
/*     */   {
/* 132 */     this.requestdate = value;
/*     */   }
/*     */ 
/*     */   public List<Vehicle> getVehicle()
/*     */   {
/* 158 */     if (this.vehicle == null) {
/* 159 */       this.vehicle = new ArrayList();
/*     */     }
/* 161 */     return this.vehicle;
/*     */   }
/*     */ 
/*     */   public Customer getCustomer()
/*     */   {
/* 173 */     return this.customer;
/*     */   }
/*     */ 
/*     */   public void setCustomer(Customer value)
/*     */   {
/* 185 */     this.customer = value;
/*     */   }
/*     */ 
/*     */   public Vendor getVendor()
/*     */   {
/* 197 */     return this.vendor;
/*     */   }
/*     */ 
/*     */   public void setVendor(Vendor value)
/*     */   {
/* 209 */     this.vendor = value;
/*     */   }
/*     */ 
/*     */   public Provider getProvider()
/*     */   {
/* 221 */     return this.provider;
/*     */   }
/*     */ 
/*     */   public void setProvider(Provider value)
/*     */   {
/* 233 */     this.provider = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Prospect
 * JD-Core Version:    0.6.2
 */