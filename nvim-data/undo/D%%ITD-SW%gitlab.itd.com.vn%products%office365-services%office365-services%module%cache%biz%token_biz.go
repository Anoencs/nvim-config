Vim�UnDo� T�{.N���?}g�7�o%ۑ�6��f�m��B      package cachebiz                              de�j    _�                            ����                                                                                                                                                                                                                                                                                                                                                v       de�L     �               func CreateToken() string {5��                         V                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       de�Q     �               func string {5��                         V                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       de�R     �               func {5��                         W                      �                         W                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       de�T     �               func {5��                         V                      �                        V                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       de�^     �                 	return utils.GenerateToken("1")5��                          e       !               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                v       de�a     �             5��                          e                      �                          e                      �                          e                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       de��     �      	   
      func ClearCache(redis *redis) {�               =import "gitlab2.itd.com.vn/products/office365-services/utils"�               =import "gitlab2.itd.com.vn/products/office365-services/utils"�               func ClearCache() {5��                         a                      �                        h                     �                        h                     �       =                 O                      �                                       #       �                        �                     5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                v       de��     �                7	"gitlab2.itd.com.vn/products/office365-services/utils"5��                          ;       8               5�_�      
           	           ����                                                                                                                                                                                                                                                                                                                                                v       de��     �   	            	redis.FlushDB(conte)�         	      import (�      	   	       5��                          e                      �                        j                     �                        l                     �                        l                     �                        l                     �                        l                     �                         x                      �                         w                      �                         v                      �                         u                      �                        t                     �                        t                     �                                               �    	                 	   �              	       �    	                     �                      �    	                    �                     �    	                     �                      �    	                     �                      �    	                     �                      �    	                 
   �              
       �    	          
          �       
              �    	                    �                     5�_�   	              
   
   $    ����                                                                                                                                                                                                                                                                                                                            	          	          v       de��     �   	            $	redis.FlushDB(context.Background())5��    	   $                  �                      �    	   %                 �                     �    	   *                  �                      5�_�   
                 
        ����                                                                                                                                                                                                                                                                                                                            	          	          v       de��     �   	            *	redis.FlushDB(context.Background()).Err()5��    	                      q                      �    	                     q                     5�_�                    
       ����                                                                                                                                                                                                                                                                                                                            	          	          v       de��     �   
            	�   
          5��    
                      �                      �    
                     �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                            	          	          v       de��     �   
            	if err != nil{}5��    
                    �                      �                          �                      �                         �                      5�_�                            ����                                                                                                                                                                                                                                                                                                                            	          	          v       de��     �                5��                          �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                            	          	          v       de��     �               	�             5��                          �                      �                      
   �               
       5�_�                    	   $    ����                                                                                                                                                                                                                                                                                                                            	          	          v       de�      �      
         &func ClearCache(redis *redis.Client) {5��       $                  n                      5�_�                    	   )    ����                                                                                                                                                                                                                                                                                                                            	          	          v       de�    �              �                package tokenbiz�             �                �             �               import (�             �               
	"context"�             �                �             �               	"github.com/redis/go-redis/v9"�             �               )�      	       �                �      
       �      	         ,func ClearCache(redis *redis.Client) error {�   	          �   	   
         1	err :=	redis.FlushDB(context.Background()).Err()�   	          �   	   
         1	err :=	redis.FlushDB(context.Background()).Err()�   
          �   
            	if err != nil{�   
          �   
            	if err != nil{�             �               		return err�             �               	}�             �               	return nil�               �                 }5��                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �    
                      �                      �    
                      �                      �    
                      �                      �    
                      �                      �    	                      w       2               �    	                      w               2       �    	                      w       2               �    	                      w               2       �                          J       -               �                          J               -       �                          I                      �                          I                      �                          G                      �                          G                      �                          '                       �                          '                       �                          &                      �                          &                      �                                                �                                                �                                 	               �                                         	       �                                                �                                                �                                                  �                                                  5�_�                           ����                                                                                                                                                                                                                                                                                                                            
          
          v       de�     �                package tokenbiz5��                                              5�_�                           ����                                                                                                                                                                                                                                                                                                                            
          
          v       de�    �              �                package cachebiz�             �                �             �               import (�             �               
	"context"�             �                �             �               	"github.com/redis/go-redis/v9"�             �               )�      	       �                �      
       �      	         ,func ClearCache(redis *redis.Client) error {�   	          �   	   
         1	err := redis.FlushDB(context.Background()).Err()�   
          �   
            	if err != nil {�             �               		return err�             �               	}�             �               	return nil�               �                 }5��                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �    
                      �                      �    
                      �                      �    	                      w       2               �    	                      w               2       �                          J       -               �                          J               -       �                          I                      �                          I                      �                          G                      �                          G                      �                          '                       �                          '                       �                          &                      �                          &                      �                                                �                                                �                                 	               �                                         	       �                                                �                                                �                                                  �                                                  5�_�                     	       ����                                                                                                                                                                                                                                                                                                                                                v       de�i    �              �                package cachebiz�             �                �             �               import (�             �               
	"context"�             �                �             �               	"github.com/redis/go-redis/v9"�             �               )�      	       �                �      
       �      	         ,func ClearCache(redis *redis.Client) error {�   	          �   	   
         1	err := redis.FlushDB(context.Background()).Err()�   
          �   
            	if err != nil {�             �               		return err�             �               	}�             �               	return nil�               �                 }5��                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �                          �                      �    
                      �                      �    
                      �                      �    	                      w       2               �    	                      w               2       �                          J       -               �                          J               -       �                          I                      �                          I                      �                          G                      �                          G                      �                          '                       �                          '                       �                          &                      �                          &                      �                                                �                                                �                                 	               �                                         	       �                                                �                                                �                                                  �                                                  5��