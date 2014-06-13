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
/*     */ @XmlType(name="", propOrder={"street", "apartment", "city", "regioncode", "postalcode", "country"})
/*     */ @XmlRootElement(name="address")
/*     */ public class Address
/*     */ {
/*     */ 
/*     */   @XmlAttribute
/*     */   @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
/*     */   protected String type;
/*     */ 
/*     */   @XmlElement(required=true)
/*     */   protected List<Street> street;
/*     */   protected String apartment;
/*     */   protected String city;
/*     */   protected String regioncode;
/*     */   protected String postalcode;
/*     */   protected String country;
/*     */ 
/*     */   public void setStreet(List<Street> street)
/*     */   {
/*  31 */     this.street = street;
/*     */   }
/*     */ 
/*     */   public String getType()
/*     */   {
/*  54 */     return this.type;
/*     */   }
/*     */ 
/*     */   public void setType(String value)
/*     */   {
/*  66 */     this.type = value;
/*     */   }
/*     */ 
/*     */   public List<Street> getStreet()
/*     */   {
/*  92 */     if (this.street == null) {
/*  93 */       this.street = new ArrayList();
/*     */     }
/*  95 */     return this.street;
/*     */   }
/*     */ 
/*     */   public String getApartment()
/*     */   {
/* 107 */     return this.apartment;
/*     */   }
/*     */ 
/*     */   public void setApartment(String value)
/*     */   {
/* 119 */     this.apartment = value;
/*     */   }
/*     */ 
/*     */   public String getCity()
/*     */   {
/* 131 */     return this.city;
/*     */   }
/*     */ 
/*     */   public void setCity(String value)
/*     */   {
/* 143 */     this.city = value;
/*     */   }
/*     */ 
/*     */   public String getRegioncode()
/*     */   {
/* 155 */     return this.regioncode;
/*     */   }
/*     */ 
/*     */   public void setRegioncode(String value)
/*     */   {
/* 167 */     this.regioncode = value;
/*     */   }
/*     */ 
/*     */   public String getPostalcode()
/*     */   {
/* 179 */     return this.postalcode;
/*     */   }
/*     */ 
/*     */   public void setPostalcode(String value)
/*     */   {
/* 191 */     this.postalcode = value;
/*     */   }
/*     */ 
/*     */   public String getCountry()
/*     */   {
/* 203 */     return this.country;
/*     */   }
/*     */ 
/*     */   public void setCountry(String value)
/*     */   {
/* 215 */     this.country = value;
/*     */   }
/*     */ }

/* Location:           /Users/bsterner/Development/Java/APIS/tms-maven-repos/SLPServiceSchema-0.0.1.jar
 * Qualified Name:     com.tms.slp20.adf.model.v1_1.Address
 * JD-Core Version:    0.6.2
 */