from app.log import logger


def check_pem_key(value: str):
    """Check if string is a valid PEM formatted key"""

    from Crypto.PublicKey import RSA  # nosec we use PyCryptodome, not PyCrypto

    try:
        RSA.importKey(value)
    except Exception as exc:
        msg = "Failed to import PEM formatted key"
        logger.exception(msg)
        raise ValueError(msg)
