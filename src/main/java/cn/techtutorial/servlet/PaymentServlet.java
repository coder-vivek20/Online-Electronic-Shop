package cn.techtutorial.servlet;
import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paymentMode = request.getParameter("mode");
        String productIdString = request.getParameter("productId");
        
        // Validate and process payment (replace with your actual logic)
        if (paymentMode != null && productIdString != null) {
            int productId = Integer.parseInt(productIdString);
            // Simulate successful payment processing
            boolean paymentSuccess = true;
            
            if (paymentSuccess) {
                request.setAttribute("message", "Online Payment Processed Successfully for Product ID: " + productId);
            } else {
                request.setAttribute("message", "Error processing online payment for Product ID: " + productId);
            }
        } else {
            request.setAttribute("message", "Missing parameters");
        }
        
        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }
}
