NAME_SERVER = server
NAME_CLIENT = client
NAME_SERVER_BONUS = server_bonus
NAME_CLIENT_BONUS = client_bonus

CC = cc
CFLAGS = -Wall -Wextra -Werror

LIBFT_DIR = libft
LIBFT = $(LIBFT_DIR)/libft.a

SRC_MANDATORY = server.c client.c 
SRC_BONUS = server_bonus.c client_bonus.c

all: $(LIBFT) $(NAME_SERVER) $(NAME_CLIENT)

$(LIBFT):
	make -C $(LIBFT_DIR)

$(NAME_SERVER): $(SRC_MANDATORY) minitalk.h $(LIBFT)
	$(CC) $(CFLAGS) -o $(NAME_SERVER) server.c $(LIBFT)

$(NAME_CLIENT): $(SRC_MANDATORY) minitalk.h $(LIBFT)
	$(CC) $(CFLAGS) -o $(NAME_CLIENT) client.c $(LIBFT)

bonus: $(LIBFT) $(NAME_SERVER_BONUS) $(NAME_CLIENT_BONUS)

$(NAME_SERVER_BONUS): server_bonus.c minitalk_bonus.h
	$(CC) $(CFLAGS) -o $@ $< $(LIBFT)

$(NAME_CLIENT_BONUS): client_bonus.c minitalk_bonus.h
	$(CC) $(CFLAGS) -o $@ $< $(LIBFT)

clean:
	make clean -C $(LIBFT_DIR)

fclean: clean
	make fclean -C $(LIBFT_DIR)
	rm -f $(NAME_SERVER) $(NAME_CLIENT) $(NAME_SERVER_BONUS) $(NAME_CLIENT_BONUS)

re: fclean all

.PHONY: all bonus clean fclean re
