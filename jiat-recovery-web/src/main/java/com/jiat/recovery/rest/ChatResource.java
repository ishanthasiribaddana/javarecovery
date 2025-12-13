package com.jiat.recovery.rest;

import com.jiat.recovery.entity.RecoveryAiConversation;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

/**
 * REST resource for chat history.
 */
@Stateless
@Path("/chat")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ChatResource {

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    /**
     * Get chat history for a specific student.
     */
    @GET
    @Path("/student/{studentSId}")
    public Response getChatByStudentId(@PathParam("studentSId") Integer studentSId) {
        try {
            List<RecoveryAiConversation> conversations = em.createNamedQuery(
                    "RecoveryAiConversation.findByStudentId", RecoveryAiConversation.class)
                    .setParameter("studentSId", studentSId)
                    .setMaxResults(50)
                    .getResultList();
            return Response.ok(conversations).build();
        } catch (Exception e) {
            return Response.ok(List.of()).build();
        }
    }
}
