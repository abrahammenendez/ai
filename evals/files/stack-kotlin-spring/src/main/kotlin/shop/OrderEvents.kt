package shop

import org.springframework.kafka.annotation.KafkaListener
import org.springframework.stereotype.Component

@Component
class OrderEvents(private val orders: OrderRepository) {
    @KafkaListener(topics = ["payments.completed"])
    fun onPaymentCompleted(orderId: String) {
        orders.markPaid(orderId)
    }
}
