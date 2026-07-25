import org.junit.jupiter.api.Test;

import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    public void testVerifyInteraction() {
        // Arrange
        ExternalApi mockApi = mock(ExternalApi.class);
        MyService service = new MyService(mockApi);
        // Act
        service.fetchData();
        // Assert (Verify)
        verify(mockApi).getData();

        System.out.println("Interaction Verified Successfully");
    }
}