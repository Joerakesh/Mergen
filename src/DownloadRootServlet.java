import java.io.*;
import java.util.zip.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadRoot")
public class DownloadRootServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Define the root folder path (change it based on your server's structure)
        String rootPath = getServletContext().getRealPath("/") + "../"; // Go to root from department folder
        
        File rootFolder = new File(rootPath);
        if (!rootFolder.exists() || !rootFolder.isDirectory()) {
            response.getWriter().write("Root folder not found!");
            return;
        }

        // Set the ZIP file name
        String zipFileName = "root_folder.zip";
        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + zipFileName + "\"");

        // Create ZIP file and send it as response
        try (ZipOutputStream zos = new ZipOutputStream(response.getOutputStream())) {
            zipFolder(rootFolder, rootFolder.getName(), zos);
        } catch (Exception e) {
            response.getWriter().write("Error: " + e.getMessage());
        }
    }

    private void zipFolder(File folder, String parentFolder, ZipOutputStream zos) throws IOException {
        for (File file : folder.listFiles()) {
            if (file.isDirectory()) {
                zipFolder(file, parentFolder + "/" + file.getName(), zos);
            } else {
                try (FileInputStream fis = new FileInputStream(file)) {
                    ZipEntry zipEntry = new ZipEntry(parentFolder + "/" + file.getName());
                    zos.putNextEntry(zipEntry);
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = fis.read(buffer)) > 0) {
                        zos.write(buffer, 0, length);
                    }
                    zos.closeEntry();
                }
            }
        }
    }
}
