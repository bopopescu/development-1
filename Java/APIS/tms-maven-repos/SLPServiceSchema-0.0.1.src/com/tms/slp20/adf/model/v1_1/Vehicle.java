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
/*     */ @XmlType(name="", propOrder={"id", "year", "make", "model", "vin", "stock", "trim", "doors", "bodystyle", "transmission", "odometer", "colorcombination", "imagetag", "price", "pricecomments", "option", "finance", "comments"})
/*     */ @XmlRootElement(name="vehicle")
/*     */ public class Vehicle
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String interest;
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String status;
/*     */   protected List<Id> id;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected String year;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected String make;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected String model;
/*     */   protected String vin;
/*     */   protected String stock;
/*     */   protected String trim;
/*     */   protected String doors;
/*     */   protected String bodystyle;
/*     */   protected String transmission;
/*     */   protected Odometer odometer;
/*     */   protected List<Colorcombination> colorcombination;
/*     */   protected Imagetag imagetag;
/*     */   protected Price price;
/*     */   protected String pricecomments;
/*     */   protected List<Option> option;
/*     */   protected Finance finance;
/*     */   protected String comments;
/*     */ 
/*     */   public void setColorcombination(List<Colorcombination> colorcombination)
/*     */   {
/*  43 */     this.colorcombination = colorcombination;
/*     */   }
/*     */ 
/*     */   public String getInterest()
/*     */   {
/*  83 */     if (this.interest == null) {
/*  84 */       return "buy";
/*     */     }
/*  86 */     return this.interest;
/*     */   }
/*     */ 
/*     */   public void setInterest(String value)
/*     */   {
/*  99 */     this.interest = value;
/*     */   }
/*     */ 
/*     */   public String getStatus()
/*     */   {
/* 111 */     if (this.status == null) {
/* 112 */       return "new";
/*     */     }
/* 114 */     return this.status;
/*     */   }
/*     */ 
/*     */   public void setStatus(String value)
/*     */   {
/* 127 */     this.status = value;
/*     */   }
/*     */ 
/*     */   public List<Id> getId()
/*     */   {
/* 153 */     if (this.id == null) {
/* 154 */       this.id = new ArrayList();
/*     */     }
/* 156 */     return this.id;
/*     */   }
/*     */ 
/*     */   public String getYear()
/*     */   {
/* 168 */     return this.year;
/*     */   }
/*     */ 
/*     */   public void setYear(String value)
/*     */   {
/* 180 */     this.year = value;
/*     */   }
/*     */ 
/*     */   public String getMake()
/*     */   {
/* 192 */     return this.make;
/*     */   }
/*     */ 
/*     */   public void setMake(String value)
/*     */   {
/* 204 */     this.make = value;
/*     */   }
/*     */ 
/*     */   public String getModel()
/*     */   {
/* 216 */     return this.model;
/*     */   }
/*     */ 
/*     */   public void setModel(String value)
/*     */   {
/* 228 */     this.model = value;
/*     */   }
/*     */ 
/*     */   public String getVin()
/*     */   {
/* 240 */     return this.vin;
/*     */   }
/*     */ 
/*     */   public void setVin(String value)
/*     */   {
/* 252 */     this.vin = value;
/*     */   }
/*     */ 
/*     */   public String getStock()
/*     */   {
/* 264 */     return this.stock;
/*     */   }
/*     */ 
/*     */   public void setStock(String value)
/*     */   {
/* 276 */     this.stock = value;
/*     */   }
/*     */ 
/*     */   public String getTrim()
/*     */   {
/* 288 */     return this.trim;
/*     */   }
/*     */ 
/*     */   public void setTrim(String value)
/*     */   {
/* 300 */     this.trim = value;
/*     */   }
/*     */ 
/*     */   public String getDoors()
/*     */   {
/* 312 */     return this.doors;
/*     */   }
/*     */ 
/*     */   public void setDoors(String value)
/*     */   {
/* 324 */     this.doors = value;
/*     */   }
/*     */ 
/*     */   public String getBodystyle()
/*     */   {
/* 336 */     return this.bodystyle;
/*     */   }
/*     */ 
/*     */   public void setBodystyle(String value)
/*     */   {
/* 348 */     this.bodystyle = value;
/*     */   }
/*     */ 
/*     */   public String getTransmission()
/*     */   {
/* 360 */     return this.transmission;
/*     */   }
/*     */ 
/*     */   public void setTransmission(String value)
/*     */   {
/* 372 */     this.transmission = value;
/*     */   }
/*     */ 
/*     */   public Odometer getOdometer()
/*     */   {
/* 384 */     return this.odometer;
/*     */   }
/*     */ 
/*     */   public void setOdometer(Odometer value)
/*     */   {
/* 396 */     this.odometer = value;
/*     */   }
/*     */ 
/*     */   public List<Colorcombination> getColorcombination()
/*     */   {
/* 422 */     if (this.colorcombination == null) {
/* 423 */       this.colorcombination = new ArrayList();
/*     */     }
/* 425 */     return this.colorcombination;
/*     */   }
/*     */ 
/*     */   public Imagetag getImagetag()
/*     */   {
/* 437 */     return this.imagetag;
/*     */   }
/*     */ 
/*     */   public void setImagetag(Imagetag value)
/*     */   {
/* 449 */     this.imagetag = value;
/*     */   }
/*     */ 
/*     */   public Price getPrice()
/*     */   {
/* 461 */     return this.price;
/*     */   }
/*     */ 
/*     */   public void setPrice(Price value)
/*     */   {
/* 473 */     this.price = value;
/*     */   }
/*     */ 
/*     */   public String getPricecomments()
/*     */   {
/* 485 */     return this.pricecomments;
/*     */   }
/*     */ 
/*     */   public void setPricecomments(String value)
/*     */   {
/* 497 */     this.pricecomments = value;
/*     */   }
/*     */ 
/*     */   public List<Option> getOption()
/*     */   {
/* 523 */     if (this.option == null) {
/* 524 */       this.option = new ArrayList();
/*     */     }
/* 526 */     return this.option;
/*     */   }
/*     */ 
/*     */   public void setOption(List<Option> options)
/*     */   {
/* 539 */     this.option = options;
/*     */   }
/*     */ 
/*     */   public Finance getFinance()
/*     */   {
/* 551 */     return this.finance;
/*     */   }
/*     */ 
/*     */   public void setFinance(Finance value)
/*     */   {
/* 563 */     this.finance = value;
/*     */   }
/*     */ 
/*     */   public String getComments()
/*     */   {
/* 575 */     return this.comments;
/*     */   }
/*     */ 
/*     */   public void setComments(String value)
/*     */   {
/* 587 */     this.comments = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Vehicle
 * JD-Core Version:    0.6.2
 */