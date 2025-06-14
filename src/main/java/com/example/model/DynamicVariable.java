package com.example.model;

public class DynamicVariable {
    private String name;
    private VariableType type;
    private Object value;
    private String scope; // "application", "session", or "request"

    public enum VariableType {
        STRING, INTEGER, BOOLEAN, DOUBLE, OBJECT
    }

    public DynamicVariable(String name, VariableType type, Object value, String scope) {
        this.name = name;
        this.type = type;
        this.value = value;
        this.scope = scope;
    }

    // Getters and setters
    public String getName() { return name; }
    public VariableType getType() { return type; }
    public Object getValue() { return value; }
    public String getScope() { return scope; }

    public void setValue(Object value) { this.value = value; }

    public String getStringValue() {
        return value != null ? value.toString() : "";
    }

    public Integer getIntValue() {
        try {
            return Integer.parseInt(value.toString());
        } catch (Exception e) {
            return 0;
        }
    }

    public Boolean getBooleanValue() {
        return Boolean.parseBoolean(value.toString());
    }

    public Double getDoubleValue() {
        try {
            return Double.parseDouble(value.toString());
        } catch (Exception e) {
            return 0.0;
        }
    }
}