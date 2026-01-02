# Absolute Value - Negative to Positive

A server-side Google Tag Manager variable template that converts negative numbers to positive (absolute value). Useful for handling refund transactions from booking engines that send negative purchase values.

## Overview

Some booking engines and e-commerce platforms cannot push a proper `refund` dataLayer event. Instead, they send a `purchase` event with a **negative value** to represent refunds. This template helps you convert those negative values to positive, allowing you to properly track refunds in GA4.

## Installation

1. In your server-side GTM container, go to **Templates** → **Variable Templates** → **Search Gallery**
2. Search for "Absolute Value"
3. Click **Add to workspace**

## Configuration

| Field | Description |
|-------|-------------|
| **Input Value** | The value to convert. If negative, returns positive. |

## Examples

| Input | Output |
|-------|--------|
| `-150.50` | `150.50` |
| `100` | `100` |
| `0` | `0` |
| `-250.99` | `250.99` |

## Use Case: Converting Negative Purchase to Refund

Some booking engines (like PHOBS and others) send refunds as negative purchase events:

```
event: purchase
value: -150.00
transaction_id: ABC123
```

### Solution

1. **Create a trigger** for negative purchases:
   - Trigger Type: Custom Event
   - Event Name: `purchase`
   - Condition: `{{Event Data - value}}` less than `0`

2. **Create an Absolute Value variable:**
   - Input Value: `{{Event Data - value}}`

3. **Create a GA4 refund tag:**
   - Event Name: `refund`
   - Parameters:
     - `transaction_id`: `{{Event Data - transaction_id}}`
     - `value`: `{{Absolute Value}}` ← uses this template
     - `currency`: `{{Event Data - currency}}`

4. **Add exception to your base GA4 tag:**
   - Exclude the negative purchase trigger so it doesn't fire as a regular purchase

### Result

- Negative purchase (`value: -150`) → GA4 refund event (`value: 150`)
- Normal purchases continue to track normally

## Why This Matters

GA4 expects refund values to be **positive numbers**. If you send a negative value to GA4's refund event, it won't be processed correctly. This template ensures your refund values are always positive.

## Author

**Metryx Studio**  
Website: [metryx.studio](https://metryx.studio)  
Contact: filip@metryx.studio

## License

Apache License 2.0
