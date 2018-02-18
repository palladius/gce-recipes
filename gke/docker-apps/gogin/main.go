
package main

import (  
    "io/ioutil"
    "log"
    "net/http"
    "gopkg.in/gin-gonic/gin.v1"
)

func readVersion() string {
    b, err := ioutil.ReadFile("VERSION")
    if err != nil {
        log.Fatal(err)
    }
    str := string(b) // convert content to a 'string'
    return str
}


func main() {  
    router := gin.Default()
    router.GET("/health", health)
    router.GET("/info", info)
    router.GET("/version", version)
    router.Run(":8007")
}

func health(c *gin.Context) {  
    c.JSON(http.StatusOK, gin.H{"status": "OK"})
}

func info(c *gin.Context) {
    c.JSON(http.StatusOK, gin.H{"version": readVersion() , "name": "GoGin"})
}


func version(c *gin.Context) {
	// should be v1.1 as "V" + File.cat("./VERSION")
	ver := readVersion()
    c.JSON(http.StatusOK, gin.H{"version": ver})
}
